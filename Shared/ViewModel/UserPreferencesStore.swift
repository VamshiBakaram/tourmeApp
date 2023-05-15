//
//  UserPreferencesStore.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 9/17/21.
//

import Foundation
import Combine
import Amplify
import AWSPluginsCore
import Purchases
import StoreKit

enum UserLanguage: String, CaseIterable, Identifiable {
    case english
    case spanish
    case portuguese
    
    var id: String { self.rawValue }
}

class UserPreferencesStore: ObservableObject {
        
    @Published var hasPurchaseRecord = false
    @Published var isLoading = false
    @Published var iapProductId = "gold_annual_non_renewing"
    
    func saveUserProfile(email: String, phone: String, displayName: String, completion: (@escaping (_ result: UserProfile?, _ error: Error?) -> Void)) {
        
        let userProfile = UserProfile(email: email, phone: phone, displayName: displayName)

        Amplify.API.mutate(request: .create(userProfile)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let userProfile):
                    print("Successfully registered user profile")
                    completion(userProfile, nil)
                case .failure(let error):
                    print("Something went wrong: \(error.localizedDescription)")
                    completion(nil, error)
                }
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
    
    func makePurchase(email: String, completion: (@escaping (_ result: Purchase?, _ error: Error?) -> Void)) {
        
        Purchases.shared.products([self.iapProductId]) { products in
            if !products.isEmpty {
                let skProduct = products[0]
                
                Purchases.shared.purchaseProduct(skProduct) { transaction, purchaserInfo, error, userCanceled in
                    if error == nil && !userCanceled {
                        print("successful purchase")
                        DispatchQueue.main.async {
                            var purchaseHistory = Purchase(email: email, enabled: true, purchaseAmount: 35.00, purchaseLevel: "Gold")
                            purchaseHistory.purchaseDate = Temporal.DateTime(Date())
                            Amplify.API.mutate(request: .create(purchaseHistory)) { event in
                                switch event {
                                case .success(let result):
                                    switch result {
                                    case .success(let purchaseRecord):
                                        print("Successfully registered purchase record")
                                        completion(purchaseRecord, nil)
                                    case .failure(let error):
                                        print("Something went wrong: \(error.localizedDescription)")
                                        completion(nil, error)
                                    }
                                case .failure(let error):
                                    print("Something went wrong: \(error.localizedDescription)")
                                    completion(nil, error)
                                }
                            }
                        }
                    } else {
                        print("user canceled or error")
                        if error != nil {
                            DispatchQueue.main.async {
                                completion(nil, error)
                            }
                        }
                    }
                }
            }
            
            /*
             if let err = error as NSError? {
                             
                 // log error details
                 print("Error: \(err.userInfo[ReadableErrorCodeKey])")
                 print("Message: \(err.localizedDescription)")
                 print("Underlying Error: \(err.userInfo[NSUnderlyingErrorKey])")

                 // handle specific errors
                 switch Purchases.ErrorCode(_nsError: err).code {
                 case .purchaseNotAllowedError:
                     showAlert("Purchases not allowed on this device.")
                 case .purchaseInvalidError:
                     showAlert("Purchase invalid, check payment source.")
                 default:
                     break
                 }
             }
             */
        }
    }
    
    func loadPurchases(emailAddress: String) {
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let purchaseRecord = Purchase.keys
        let predicate = purchaseRecord.email == emailAddress && purchaseRecord.enabled == true
        Amplify.API.query(request: .list(Purchase.self, where: predicate)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let data):
                    print("Successfully retrieved list of records: \(data)")
                    DispatchQueue.main.async {
                        self.hasPurchaseRecord = data.count > 0
                        self.isLoading = false
                    }
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    DispatchQueue.main.async {
                        self.hasPurchaseRecord = false
                        //self.error = error
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                DispatchQueue.main.async {
                    self.hasPurchaseRecord = false
                    //self.error = error
                    self.isLoading = false
                }
            }
        }
    }
}
