//
//  NetworkManager.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 26/12/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum NetworkError: Error{
    case message(message: String)
    case error(error: String)
}

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    private override init() {}
    
    func request<T : Decodable>(type : T.Type, url: String, httpMethod: HTTPMethod = .get, parameters: Encodable? = nil, isTokenRequired: Bool = true, completion completionHandler: @escaping(Result<T, NetworkError>) -> Void){
        guard let url = URL(string: url) else {
            completionHandler(.failure(.error(error: "Invalid URL")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        print(url)
        if isTokenRequired {
            let sessionManager = SessionManager()
            request.setValue("Bearer \(sessionManager.token ?? "")", forHTTPHeaderField: "Authorization")
            print(sessionManager.token ?? "")
        }
        if parameters != nil {
            if let params = parameters {
                guard let httpBody = try? JSONEncoder().encode(params) else {
                    completionHandler(.failure(.error(error: "Invalid parameters")))
                    return
                }
                request.httpBody = httpBody
            }
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        let session = URLSession(configuration: configuration)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print(error)
                switch error._code {
                case -1009:
                    DispatchQueue.main.async {
                        completionHandler(.failure(.error(error: "The Internet connection appears to be offline.")))
                    }
                    return
                case -1001:
                    DispatchQueue.main.async {
                        completionHandler(.failure(.error(error: "Time out, please try again")))
                    }
                    return
                default:break
                }
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(error: "Unable to complete, please try again later")))
                }
                return
            }
            guard let httpData = data else{
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(error: "Invalid Data, Please try again later")))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<399).contains(httpResponse.statusCode) else {
                do
                {
                    let errorjsonData = try JSONSerialization.jsonObject(with: httpData)
                    print(errorjsonData)
                    let errorjson = try JSONDecoder().decode(ErrorHandlerModel.self, from: httpData)
                    if let validationError = errorjson.status {
                        DispatchQueue.main.async {
                            completionHandler(.failure(.error(error: validationError)))
                        }
                        return
                    }else{
                        completionHandler(.failure(.error(error: "Please try again later")))
                        return
                    }
                }catch{
                    print(error)
                    DispatchQueue.main.async {
                        completionHandler(.failure(.error(error: "Decoding error")))
                    }
                    return
                }
            }
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: httpData)
                print(jsonData)
                let json = try JSONDecoder().decode(T.self, from: httpData)
                DispatchQueue.main.async {
                    completionHandler(.success(json))
                }
            }catch{
                print(error)
                DispatchQueue.main.async {
                    completionHandler(.failure(.error(error: "Decoding error")))
                }
            }
        }.resume()
    }
}

struct ErrorHandlerModel: Decodable {
    let message: String?
    let status: String?
}
