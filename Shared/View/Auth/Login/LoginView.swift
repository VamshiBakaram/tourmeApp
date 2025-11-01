//
//  LoginView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 19/12/23.
//

import SwiftUI
import ToastSwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isShowPassword = false
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var loginViewModel = LoginViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("displayName") var userDisplayName = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("tourmeapp_logo")
                        .padding(.top)
                    
                    HStack {
                        Text("Login".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text("Email Address".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        HStack {
                            Image("mail 1")
                            TextField("Enter email".localized(userLanguage) ,text: $loginViewModel.email)
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
                    
                    VStack(alignment: .leading) {
                        Text("Password".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        HStack {
                            Image("lock")
                            if !isShowPassword {
                                SecureField("Enter Password".localized(userLanguage) ,text: $loginViewModel.password)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }else{
                                TextField("Enter Password".localized(userLanguage) ,text: $loginViewModel.password)
                                    .padding(.vertical)
                                    .padding(.horizontal, 4)
                            }
                            Button(action: {
                                isShowPassword.toggle()
                            }, label: {
                                Text(isShowPassword ? "HIDE".localized(userLanguage) : "SHOW".localized(userLanguage))
                                    .font(.custom(.inriaSansRegular, size: 14))
                                  .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                            })
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
                    .padding(.top)
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            ResetPasswordView()
                                .navigationBarHidden(true)
                        } label: {
                            Text("Forgot Password?".localized(userLanguage))
                                .font(.custom(.inriaSansRegular, size: 18))
                                .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                .padding(.vertical)
                        }
                        
                    }
                    
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        loginViewModel.login { token in
                            sessionManager.token = token.data?.token ?? ""
                            sessionManager.userId = token.data?.userID ?? ""
                            sessionManager.email = token.data?.email ?? ""
//                            userDisplayName = token.data?.userName ?? ""
//                            sessionManager.displayName = token.data?.userName ?? ""
                            sessionManager.authManager = "home"
                        }
                    } label: {
                        Text("Log In".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                            .cornerRadius(5)
                    }
                    
                    HStack {
                        Text("New to Tourme App?".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 20))
                            .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        Spacer()

                    }
                    .padding(.top,12)
                    HStack{
//                        NavigationLink(destination: SignUpView().navigationBarHidden(true), isActive: $sessionManager.isShowSignUp, label: {
//                            Text("Sign Up".localized(userLanguage))
//                                .font(.custom(.inriaSansRegular, size: 18))
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 50)
//                                .background(Color.blue)
//                                .cornerRadius(5)
//                                .onTapGesture {
//                                    sessionManager.isShowSignUp = true
//                                }
//                        })
                       
                        NavigationLink(destination: SignUpView().navigationBarHidden(true)
                        ) {
                            Text("Register".localized(userLanguage))
                                .font(.custom(.inriaSansRegular, size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                        
                    }
                    .padding(.top,12)
                    Spacer()
                }
                .padding(.horizontal)
                if loginViewModel.isShowIndicator {
                    ShowProgressView()
                }
            }
            .toast($loginViewModel.errorMessage)
        }
        
    }
}

#Preview {
    LoginView()
}


struct ShowProgressView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ProgressView()
            .tint(colorScheme == .dark ? .white : .black)
    }
}
