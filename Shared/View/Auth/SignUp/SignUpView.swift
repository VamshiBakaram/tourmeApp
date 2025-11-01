//
//  SignUpView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 19/12/23.
//

import SwiftUI
import ToastSwiftUI

struct SignUpView: View {
    
    @State var isShowPassword = false
    @State var isShowConfirmPassword = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sessionManager: SessionManager

    
    @ObservedObject var signUpViewModel = SignUpViewModel()

    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    
    @State var isShowProfile = false

    var body: some View {
        NavigationView{
            if isShowProfile {
                UserProfileScreenView(image: "en_gedi_israel", title: "onboarding_user_profile_title".localized(userLanguage), detail: "May we have some Information?", bgColor: Color("PrimaryColor2"), emailFromSignUp: signUpViewModel.email, displayNameFromSignUp: signUpViewModel.familyName, isFromSettings: false)
                    .transition(.scale)
            }else{
                ZStack {
                    ScrollView {
                        VStack {
                            Image("tourmeapp_logo")
                                .padding(.top)
                            
                            HStack {
                                Text("Register".localized(userLanguage))
                                    .font(.custom(.inriaSansRegular, size: 40))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            VStack(spacing: 20, content: {
                                VStack(alignment: .leading) {
                                    Text("Email Address".localized(userLanguage))
                                      .font(.custom(.inriaSansRegular, size: 18))
                                      .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    HStack {
                                        Image("mail 1")
                                        TextField("Enter Email".localized(userLanguage) ,text: $signUpViewModel.email)
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
                                
                                /*
                                 VStack(alignment: .leading) {
                                     Text("Display Name".localized(userLanguage))
                                       .font(.custom(.inriaSansRegular, size: 18))
                                       .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                     HStack {
                                         Image("mail 1")
                                         TextField("Enter Display Name".localized(userLanguage) ,text: $signUpViewModel.displayName)
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
                                 */
                                
                                VStack(alignment: .leading) {
                                    Text("Full Name".localized(userLanguage))
                                      .font(.custom(.inriaSansRegular, size: 18))
                                      .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    HStack {
                                        Image("mail 1")
                                        TextField("Enter Full Name".localized(userLanguage) ,text: $signUpViewModel.familyName)
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
                                        if isShowPassword {
                                            TextField("Enter Password".localized(userLanguage) ,text: $signUpViewModel.password)
                                                .padding(.vertical)
                                                .padding(.horizontal, 4)
                                        }else{
                                            SecureField("Enter Password".localized(userLanguage) ,text: $signUpViewModel.password)
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
                                
                                HStack{
                                    Text("Tip : Password should be minimum 6 characters")
                                        .padding(.leading,10)
                                        .padding(.top,-5)
                                        .font(.custom(.inriaSansRegular, size: 15))
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Confirm Password".localized(userLanguage))
                                        .font(.custom(.inriaSansRegular, size: 18))
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    HStack {
                                        Image("lock")
                                        if isShowConfirmPassword {
                                            TextField("Confirm Password".localized(userLanguage) ,text: $signUpViewModel.confirmPassword)
                                                .padding(.vertical)
                                                .padding(.horizontal, 4)
                                        }else{
                                            SecureField("Confirm Password".localized(userLanguage) ,text: $signUpViewModel.confirmPassword)
                                                .padding(.vertical)
                                                .padding(.horizontal, 4)
                                        }
                                        Button(action: {
                                            isShowConfirmPassword.toggle()
                                        }, label: {
                                            Text(isShowConfirmPassword ? "HIDE".localized(userLanguage) : "SHOW".localized(userLanguage))
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

                            })
                            Button {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                signUpViewModel.signUp { token in
                                    sessionManager.token = token.data?.token ?? ""
                                    sessionManager.userId = token.data?.userID ?? ""
                                    sessionManager.email = signUpViewModel.email
                                    sessionManager.familyName = signUpViewModel.familyName
                                    sessionManager.displayName = signUpViewModel.familyName
                                    isShowProfile = true
                                  //  isFirstLaunch = false
                                }
                            } label: {
                                Text("Register".localized(userLanguage))
                                    .font(.custom(.inriaSansRegular, size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                                    .cornerRadius(5)
                            }
                            .padding(.top)
                            
                            HStack {
                                Text("Already have an account?".localized(userLanguage))
                                    .font(.custom(.inriaSansRegular, size: 20))
                                    .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                    .padding(.top,12)
                                    .padding(.leading,10)
                                Spacer()
                               // Button {
                                   // presentationMode.wrappedValue.dismiss()
                                    /*
                                     NavigationLink {
                                         LoginView().navigationBarHidden(true)
                                     } label: {
                                         Text("Sign In".localized(userLanguage))
                                             .font(.custom(.inriaSansRegular, size: 20))
                                             .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                             .padding(.vertical)
                                             .underline()
                                     }
                                     */

                            }
                            NavigationLink(destination: LoginView().navigationBarHidden(true)
                            ) {
                                Text("Log In".localized(userLanguage))
                                    .font(.custom(.inriaSansRegular, size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(5)
                                    .padding(.leading,12)
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                    if signUpViewModel.isShowLoader {
                        ShowProgressView()
                    }
                }
                .toast($signUpViewModel.errorMessage)
                .onAppear {
                    registerForNotifications()
                }
            }
        }
        
        
    }
    
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            isFirstLaunch = false
        }

        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            isFirstLaunch = false
        }
    }
}

#Preview {
    SignUpView()
}
