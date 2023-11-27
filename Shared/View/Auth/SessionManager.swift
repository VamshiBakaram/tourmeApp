//
//  SessionManager.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//

import Amplify
import Combine

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    //case session(user: AuthUser)
    case resetPassword
    case confirmResetPassword(username: String)
    case disabled
}

struct OldUserProfile {
    var email = ""
    var givenName = ""
    var familyName = ""
    var phone = ""
    var memberSinceDate = ""
}

final class SessionManager: ObservableObject {
    
    @Published var authState: AuthState = .disabled
    
    var userProfile = OldUserProfile()
    
    private var username: String = ""
    private var password: String = ""
    
    func getCurrentAuthUser() {
//        if let user = Amplify.Auth.getCurrentUser() {
//            self.getCurrentAuthUserAttributes()
//            username = ""
//            password = ""
//            authState = .disabled //.session(user: user)
//        } else {
//            authState = .disabled
//        }
    }
    
    func getCurrentAuthUserAttributes() {
//        Amplify.Auth.fetchUserAttributes() { result in
//            switch result {
//            case .success(let attributes):
//                print("User attributes - \(attributes)")
//                self.userProfile.email = attributes.first(where: {$0.key == .email})!.value
//                self.userProfile.givenName = attributes.first(where: {$0.key == .givenName})!.value
//                self.userProfile.familyName = attributes.first(where: {$0.key == .familyName})!.value
//            case .failure(let error):
//                print("Fetch user attributes failed with error \(error)")
//                Amplify.Auth.signOut()
//            }
//        }
        
//        Amplify.Auth.fetchUserAttributes()
//            .resultPublisher
//            .sink {
//                if case let .failure(authError) = $0 {
//                    print("Fetch user attributes failed with error \(authError)")
//                }
//            }
//            receiveValue: { attributes in
//                print("User attributes - \(attributes)")
//            }
    }
    
    func showSignUp() {
        //authState = .signUp
    }
    
    func showLogin() {
        //authState = .login
    }
    
    func showResetPassword() {
        //authState = .resetPassword
    }
    
    func signUp(username: String, password: String, email: String, givenName: String, familyName: String, completion: (@escaping (_ error: AuthError) -> Void)) {
//        let attributes = [AuthUserAttribute(.email, value: email), AuthUserAttribute(.givenName, value: givenName), AuthUserAttribute(.familyName, value: familyName)]
//        let options = AuthSignUpRequest.Options(userAttributes: attributes)
//        
//        _ = Amplify.Auth.signUp(username: username, password: password, options: options) { [weak self] result in
//            switch result {
//            case .success(let signUpResult):
//                switch signUpResult.nextStep {
//                case .confirmUser(let details, _):
//                    print(details ?? "no details")
//                    
//                    self?.username = email
//                    self?.password = password
//                    
//                    DispatchQueue.main.async {
//                        self?.authState = .confirmCode(username: username)
//                    }
//                case .done:
//                    self?.authState = .login
//                }
//            case .failure(let error):
//                /*
//                print("Sign up error", error)
//                print(error.errorDescription)
//                print(error.localizedDescription)
//                print(error.debugDescription)
//                print(error.recoverySuggestion)
//                 */
//                completion(error)
//            }
//        }
    }
    
    func confirm(username: String, code: String, completion: (@escaping (_ error: Error) -> Void)) {
//        _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: code) { [weak self] result in
//            switch result {
//            case .success(let confirmResult):
//                if confirmResult.isSignupComplete {
//                    DispatchQueue.main.async {
//                        
//                        self?.login(username: self!.username, password: self!.password) { error in
//                            if error == nil {
//                                self?.getCurrentAuthUser()
//                            } else {
//                                self?.authState = .login
//                            }
//                        }
//                        
//                    }
//                }
//            case .failure(let error):
//                print("failed to confirm code:", error)
//                completion(error)
//            }
//        }
    }
    
    func resetPassword(username: String, completion: (@escaping (_ error: Error) -> Void)) {
//        Amplify.Auth.resetPassword(for: username) { [weak self] result in
//            do {
//                let resetResult = try result.get()
//                switch resetResult.nextStep {
//                case .confirmResetPasswordWithCode(let deliveryDetails, let info):
//                    print("Confirm reset password with code sent to - \(deliveryDetails) \(info)")
//                    DispatchQueue.main.async {
//                        self?.authState = .confirmResetPassword(username: username)
//                    }
//                case .done:
//                    print("Reset complete")
//                }
//            } catch {
//                print("Reset password failed with error \(error)")
//                completion(error)
//            }
//        }
    }
    
    func confirmResetPassword(
        username: String,
        password: String,
        confirmationCode: String,
        completion: (@escaping (_ error: Error?) -> Void)
    ) {
//        Amplify.Auth.confirmResetPassword(for: username, with: password, confirmationCode: confirmationCode) { [weak self] result in
//            switch result {
//            case .success:
//                print("Password reset confirmed")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            case .failure(let error):
//                print("Reset password failed with error \(error)")
//                completion(error)
//            }
//        }
    }
    
    func login(username: String, password: String, completion: (@escaping (_ error: Error) -> Void)) {
//        self.username = username
//        self.password = password
//        
//        _ = Amplify.Auth.signIn(
//            username: username,
//            password: password) { [weak self] result in
//            switch result {
//            case .success(let signInResult):
//                switch signInResult.nextStep {
//                case .resetPassword(nil):
//                    DispatchQueue.main.async {
//                        self?.authState = .confirmResetPassword(username: username)
//                    }
//                case .done:
//                    print("Signed In Successfully")
//                case .confirmSignInWithSMSMFACode(_, _):
//                    print("Feature not implemented")
//                case .confirmSignInWithCustomChallenge(_):
//                    print("Feature not implemented")
//                case .confirmSignInWithNewPassword(_):
//                    DispatchQueue.main.async {
//                        self?.authState = .confirmResetPassword(username: username)
//                    }
//                case .resetPassword(.some(_)):
//                    DispatchQueue.main.async {
//                        self?.authState = .resetPassword
//                    }
//                case .confirmSignUp(_):
//                    DispatchQueue.main.async {
//                        self?.authState = .confirmCode(username: username)
//                    }
//                }
//                
//                if signInResult.isSignedIn {
//                    DispatchQueue.main.async {
//                        self?.getCurrentAuthUser()
//                    }
//                }
//            case .failure(let error):
//                print("Login error:", error)
//                completion(error)
//            }
//        }
    }
    
    
    func signOut() {
//        _ = Amplify.Auth.signOut { [weak self] result in
//            switch result {
//            case .success():
//                DispatchQueue.main.async {
//                    self?.userProfile = OldUserProfile()
//                    self?.getCurrentAuthUser()
//                }
//            case .failure(let error):
//                print("Sign out error:", error)
//            }
//        }
    }
    
    func deleteUser() {
//        Amplify.Auth.deleteUser() { [weak self] result in
//            switch result {
//            case .success:
//                print("Successfully deleted user")
//                DispatchQueue.main.async {
//                    self?.authState = .login
//                }
//            case .failure(let authError):
//                print("Delete user failed with \(authError)")
//            }
//        }
    }
}
