//
//  LoginViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 26/12/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isShowIndicator = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    func login(completion: @escaping(LoginModel) -> Void) {
        if email.isEmpty {
            errorMessage = "Please enter email".localized(userLanguage)
            return
        }
        if password.isEmpty {
            errorMessage = "Please enter password".localized(userLanguage)
            return
        }
        self.isShowIndicator = true
        let parameters = LoginParameters(email: self.email, password: self.password)
        NetworkManager.shared.request(type: LoginModel.self, url: API.login, httpMethod: .post, parameters: parameters, isTokenRequired: false) { [weak self]result in
            guard let self = self else {
                self?.isShowIndicator = false
                return
            }
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    self.isShowIndicator = false
                    self.errorMessage = "Logged in successfully".localized(self.userLanguage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        completion(response)
                    })
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isShowIndicator = false
                    switch error {
                    case .message(message: let message):
                        if message == "error" {
                            self.errorMessage = "Invalid details".localized(self.userLanguage)
                        }
                    case .error(error: let error):
                        if error == "error" {
                            self.errorMessage = "Invalid details".localized(self.userLanguage)
                        }else{
                            self.errorMessage = error
                        }
                    }
                }
            }
            
        }
    }
}


struct LoginModel: Decodable {
    let message: String?
    let data: LoginDataModel?
}

struct LoginDataModel: Decodable {
    let token, userID: String?
    let status: String?
    let userName: String?
    let email:String?
    enum CodingKeys: String, CodingKey {
        case token
        case userID = "userId"
        case status
        case userName
        case email
    }
}


struct LoginParameters: Encodable {
    let email: String
    let password: String
}
