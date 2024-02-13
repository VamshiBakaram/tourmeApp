//
//  PayPalViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 30/11/23.
//

import PayPal
import PayPalCheckout

class PayPalViewModel: ObservableObject {
    
    @Published var isSuccess = false
    @Published var isLoading = false
    var orderId: String = ""
    
    func initiatePayment(amount: Double) {
        getPayPalAuthToken(amount: amount)
    }
    func getPayPalAuthToken(amount: Double) {
        isLoading = true
        let tokenEndpoint = "https://api-m.sandbox.paypal.com/v1/oauth2/token"
        let clientID = "AYRhpb1tU8a5lhNMquJbGbVjYB1--mXupCRLswEufAGS5FG5CcUwwrqIoWV_h98qOznVHCRo6ma8Z10X"
        let secret = "ECQPyRsvc0L16tB1hKTa69RX2j-BZZIsWeU4UjdRTLIrzLMMn56QFyKI_Xnh4ws4toSjOJesJ_bUE-WJ"
        
        let credentials = "\(clientID):\(secret)"
        guard let credentialsData = credentials.data(using: .utf8) else {
            print("Error encoding credentials")
            isLoading = false
            return
        }
        let base64Credentials = credentialsData.base64EncodedString()
        
        guard let url = URL(string: tokenEndpoint) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        let body = "grant_type=client_credentials"
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                self.isLoading = false
                return
            }
            
            guard let data = data else {
                print("No data received")
                self.isLoading = false
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Token Response: \(json?["access_token"] ?? [:])")
                DispatchQueue.main.async {
                    let accessToken = json?["access_token"] ?? [:]
                    self.getPayPalOrderId(accessToken: accessToken as! String, amount: amount)
                }
            } catch {
                print("Error parsing JSON: \(error)")
                self.isLoading = false
            }
        }
        
        task.resume()
    }
    
    func getPayPalOrderId(accessToken: String, amount: Double) {
        let orderEndpoint = "https://api-m.sandbox.paypal.com/v2/checkout/orders"
        guard let url = URL(string: orderEndpoint) else {
            print("Invalid URL")
            self.isLoading = false
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: Any] = [
            "intent": "CAPTURE",
            "purchase_units": [
                [
                    "amount": [
                        "currency_code": "USD",
                        "value": String(amount)
                    ]
                ]
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("Error creating request body: \(error)")
            isLoading = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                self.isLoading = false
                return
            }
            
            guard let data = data else {
                print("No data received")
                self.isLoading = false
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let orderId = json?["id"] as? String {
                    print("Order ID: \(orderId)")
                    self.orderId = (orderId)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        let config = CoreConfig(clientID: "AYRhpb1tU8a5lhNMquJbGbVjYB1--mXupCRLswEufAGS5FG5CcUwwrqIoWV_h98qOznVHCRo6ma8Z10X", environment: .sandbox)
                        let paypalNativeClient = PayPalNativeCheckoutClient(config: config)
                        paypalNativeClient.delegate = self
                        let request = PayPalNativeCheckoutRequest(orderID: orderId)
                        Task {
                            await paypalNativeClient.start(request: request)
                        }
                    }
                } else {
                    print("Error getting order ID. Response: \(json ?? [:])")
                    self.isLoading = false
                }
            } catch {
                print("Error parsing JSON: \(error)")
                self.isLoading = false
            }
        }
        
        task.resume()
    }
    
    func savePayment() {
        self.isLoading = true
        NetworkManager.shared.request(type: ResetPasswordModel.self, url: "\(API.savePayment)\(orderId)", httpMethod: .post) { _ in
            DispatchQueue.main.async {
                self.isSuccess = true
                self.isLoading = false
            }
        }
    }
    
}

extension PayPalViewModel: PayPalNativeCheckoutDelegate {
    func paypal(_ payPalClient: PayPal.PayPalNativeCheckoutClient, didFinishWithResult result: PayPal.PayPalNativeCheckoutResult) {
        self.isLoading = false
        self.savePayment()
    }
    
    func paypal(_ payPalClient: PayPal.PayPalNativeCheckoutClient, didFinishWithError error: PayPal.CoreSDKError) {
        print(error)
        self.isLoading = false
    }
    
    func paypalDidCancel(_ payPalClient: PayPal.PayPalNativeCheckoutClient) {
        print("did cancel")
        self.isLoading = false
    }
    
    func paypalWillStart(_ payPalClient: PayPal.PayPalNativeCheckoutClient) {
        print("will start")
        self.isLoading = false
    }
    
    
}
