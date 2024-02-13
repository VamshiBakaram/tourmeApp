//
//  SignUpViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var familyName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var displayName = ""
    
    @Published var errorMessage: String?
    
    @Published var isShowLoader = false
    
    @Published var isShowProfile = false
    
    
    func signUp(completion: @escaping(SignUpModel) -> Void) {
        if email.isEmpty {
            errorMessage = "Please enter email"
            return
        }
        if displayName.isEmpty {
            errorMessage = "Please enter display name"
            return
        }
        if familyName.isEmpty {
            errorMessage = "Please enter family name"
            return
        }
        if displayName == familyName {
            errorMessage = "Display name and family name should not be same"
            return
        }
        if password.isEmpty {
            errorMessage = "Please enter password"
            return
        }
        if confirmPassword.isEmpty {
            errorMessage = "Please enter confirm password"
            return
        }
        isShowLoader = true
        let parameters = SignUpParameters(email: email, familyName: familyName, password: password, username: displayName)
        NetworkManager.shared.request(type: SignUpModel.self, url: API.signup, httpMethod: .post, parameters: parameters, isTokenRequired: false) { [weak self]result in
            guard let self = self else { return }
            isShowLoader = false
            switch result {
            case .success(let response):
                errorMessage = response.message ?? ""
                self.isShowProfile = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    completion(response)
                })
            case .failure(let error):
                switch error {
                case .message(message: let message):
                    errorMessage = message
                case .error(error: let error):
                    errorMessage = error
                }
            }
            
        }
        
    }
    


}

struct SignUpParameters: Encodable {
    let email: String
    let familyName: String
    let password: String
    let username: String
}


struct SignUpModel: Decodable {
    let message: String?
    let errorCode, errorMessage: String?
    let data: SignUpDataModel?

    enum CodingKeys: String, CodingKey {
        case message
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }
}

struct SignUpDataModel: Decodable {
    let token, expiration, userID, userName: String?

    enum CodingKeys: String, CodingKey {
        case token, expiration
        case userID = "userId"
        case userName
    }
}
