//
//  ResetPasswordView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 19/12/23.
//

import SwiftUI
import ToastSwiftUI

struct ResetPasswordView: View {
    
    @State var email: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State var isShowOTPScreen = false
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @State var errorMessage: String?
    @State var isLoading = false
 
    var body: some View {
        if isShowOTPScreen {
            PasswordOTPView(email: email)
                .navigationBarHidden(true)
        }else{
            ZStack {
                VStack(spacing: 20) {
                    Image("tourmeapp_logo")
                        .padding(.top)
                    
                    HStack {
                        Text("Reset Password".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Email Your Email Address".localized(userLanguage))
                          .font(.custom(.inriaSansRegular, size: 18))
                          .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        HStack {
                            Image("mail 1")
                            TextField("Enter email".localized(userLanguage) ,text: $email)
                                .padding(.vertical)
                                .padding(.horizontal, 4)
                        }
                        .padding()
                        .frame(height: 50)
                        .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: colorScheme == .light ? 1 : 0)
                            
                        )
                    }
                    
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        if email.isEmpty {
                            errorMessage = "Please enter email"
                        }else if !isValidEmail(email) {
                            errorMessage = "Please valid email address"
                        }else{
                            self.isLoading = true
                            resetOTP()
                        }
                    } label: {
                        Text("Reset Password".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                            .cornerRadius(5)
                    }.padding(.top)
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.95, green: 0.42, blue: 0.11))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(colorScheme == .light ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.95, green: 0.42, blue: 0.11), lineWidth: 1)
                                
                            )
                    }
                    Spacer()
                }
                .padding(.horizontal)
                if isLoading {
                    ShowProgressView()
                }
            }
            .toast($errorMessage)
        }
        
    }
    
    func resetOTP() {
        NetworkManager.shared.request(type: ForgotPasswordModel.self, url: "\(API.forgotPassword)\(email)", httpMethod: .post) { result in
            switch result {
            case .success(let response):
                isLoading = false
                if response.status == "Success" {
                    errorMessage = response.error_message ?? ""
                    self.isShowOTPScreen = true
                }
            case .failure(_):
                isLoading = false
                errorMessage = "Your account is deleted or deactivated"
            }
        }
    }
}



#Preview {
    ResetPasswordView()
}

extension View {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct ForgotPasswordModel: Decodable {
    let status: String?
    let error_message: String?
}
