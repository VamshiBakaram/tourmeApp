//
//  ConfirmResetPassword.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 10/23/21.
//

import SwiftUI
import Amplify

struct ConfirmResetPassword: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var confirmationCode = ""
    @State var password = ""
    
    @State var isLoading = false
    @State var error: Error?
    
    @State var isShowingPasswordResetSuccessful = false
    
    let username: String
    
    var body: some View {
        
        if isLoading {
            Spacer()
            
            Text("login_please_wait".localized(userLanguage))
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
            
            Spacer()
        } else {
            
            VStack {
                
                Spacer()
                
                Image("tourmeapplogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .shadow(color: .white, radius: 30)
                    .shadow(color: .white, radius: 30)
                    .shadow(color: .white, radius: 30)
                
                if self.error != nil {
                    let e = error as? AuthError
                    Text(e?.errorDescription ?? "confirm_code_confirmation_failed".localized(userLanguage))
                        .foregroundColor(.white)
                }
                
                Text("\("confirm_code_email_address".localized(userLanguage)) \(username)")
                    .foregroundColor(.white)
                
                TextField("confirm_code_confirmation_code".localized(userLanguage), text: $confirmationCode)
                    .pretty()
                    .keyboardType(.numberPad)
                SecureField("confirm_reset_password_new_password".localized(userLanguage), text: $password)
                    .pretty()
                Button("confirm_reset_password_confirm".localized(userLanguage), action: {
                    self.error = nil
                    self.isLoading = true
                    hideKeyboard()
//                    sessionManager.confirmResetPassword(username: username, password: password, confirmationCode: confirmationCode) { error in
//                        
//                        self.isLoading = false
//                        self.error = error
//                        
//                        if error == nil {
//                            isShowingPasswordResetSuccessful = true
//                        }
//                        
//                        
//                    }
                }).authAccent3Button()
                
                Spacer()
                
                Button("confirm_code_return_to_log_in".localized(userLanguage), action: {
                    //sessionManager.showLogin()
                })
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .background(
              LinearGradient(gradient: Gradient(colors: [ Color("PrimaryColor2"), Color("PrimaryColor")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
            .alert(isPresented: $isShowingPasswordResetSuccessful) {
                Alert(title: Text("Password Reset Successful"),
                      message: Text("Please log in with your new password"),
                      dismissButton: .default(Text("OK")) {
                    //sessionManager.showLogin()
                })
            }
            
        }
    }
}

struct ConfirmResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmResetPassword(username: "jb")
            .environmentObject(SessionManager())
    }
}
