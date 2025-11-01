//
//  PasswordOTPView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 19/12/23.
//

import SwiftUI
import ToastSwiftUI

struct PasswordOTPView: View {
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
        
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    private let numberOfFields: Int = 6
    @FocusState private var fieldFocus: Int?
    @State var enterValue: [String] = Array(repeating: "", count: 6)
    @State var oldValue = ""
    @State var otp = ""
    @State var isShowPassword = false
    @State var isShowConfirmPassword = false
    @State var errorMessage: String?
    @EnvironmentObject var sessionManager: SessionManager
    @State var isLoading = false
    
    @State var isShowLogin = false
    
    var email: String
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("tourmeapp_logo")
                        .padding(.top)
                    
                    HStack {
                        Text("Reset Password")
                            .font(.custom(.inriaSansRegular, size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        ForEach(0..<numberOfFields, id: \.self) { index in
                            TextField("", text: $enterValue[index], onEditingChanged: { editing in
                                if editing {
                                    oldValue = enterValue[index]
                                }
                            })
                                .keyboardType(.numberPad)
                                .frame(width: 40, height: 48)
                                .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                                .cornerRadius(5)
                                .multilineTextAlignment(.center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.28, green: 0.28, blue: 0.28), lineWidth: 1)
                                    
                                )
                                .focused($fieldFocus, equals: index)
                                .tag(index)
                                .onChange(of: enterValue[index]) { newValue in
                                    if !newValue.isEmpty {
                                        if enterValue[index].count > 1 {
                                            let currentValue = Array(enterValue[index])
                                            if currentValue[0] == Character(oldValue) {
                                                enterValue[index] = String(enterValue[index].suffix(1))
                                            } else {
                                                enterValue[index] = String(enterValue[index].prefix(1))
                                            }
                                        }
                                        if index == numberOfFields-1 {
                                            fieldFocus = nil
                                        } else {
                                            fieldFocus = (fieldFocus ?? 0) + 1
                                        }
                                    } else {
                                        fieldFocus = (fieldFocus ?? 0) - 1
                                    }
                                }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Enter New Password")
                          .font(.custom(.inriaSansRegular, size: 18))
                          .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        HStack {
                            Image("lock")
                            if isShowPassword {
                                TextField("Enter Password" ,text: $password)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }else{
                                SecureField("Enter Password" ,text: $password)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }
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
                    
                    VStack(alignment: .leading) {
                        Text("Confirm New Password")
                          .font(.custom(.inriaSansRegular, size: 18))
                          .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        HStack {
                            Image("lock")
                            if isShowConfirmPassword {
                                TextField("Enter Password" ,text: $confirmPassword)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }else{
                                SecureField("Enter Password" ,text: $confirmPassword)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }
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
                        if enterValue.count < 6 {
                            errorMessage = "Enter OTP"
                        }else if password.isEmpty {
                            errorMessage = "Enter Password"
                        }else if confirmPassword.isEmpty {
                            errorMessage = "Confirm Password"
                        }else if password != confirmPassword {
                            errorMessage = "Password and confirm password should be same"
                        }else{
                            forgotPassword()
                        }
                    } label: {
                        Text("Save New Password")
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
                        Text("Back")
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
                }.padding(.horizontal)
            }
            .toast($errorMessage)
            if isLoading {
                ShowProgressView()
            }
            if isShowLogin{
                LoginView()
            }
            
        }
    }
    
    func forgotPassword() {
        self.isLoading = true
        let parameters = ResetPassword(code: enterValue.joined(separator: ""), email: self.email, newPassword: password)
        print(parameters)
        NetworkManager.shared.request(type: ResetPasswordModel.self, url: API.resetPassword, httpMethod: .post, parameters: parameters) { result in
            switch result {
            case .success(_):
                self.isLoading = false
                self.isShowLogin = true
               // sessionManager.authManager = "login"
//            case .failure(_):
//                self.isLoading = false
//                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
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

#Preview {
    PasswordOTPView(email: "")
}

struct ResetPassword: Encodable {
    let code: String
    let email: String
    let newPassword: String
}

struct ResetPasswordModel: Decodable {
    let status: String?
}
