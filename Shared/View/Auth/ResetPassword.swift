//
//  ResetPassword.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 10/23/21.
//

import SwiftUI
import Amplify

struct ResetPassword: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @State var username: String = ""
    
    @State var isLoading = false
    @State var error: Error?
    
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        
        if isLoading {
            Spacer()
            
            Text("login_please_wait".localized(userLanguage))
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
            
            Spacer()
        } else {
            
        }
        
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
                Text(e?.errorDescription ?? "reset_password_reset_password_failed".localized(userLanguage))
                    .foregroundColor(.white)
            }
            
            Text("reset_password_enter_your_email_address".localized(userLanguage))
                .foregroundColor(.white)
            
            TextField("reset_password_email_address".localized(userLanguage), text: $username)
                .pretty()
                .autocapitalization(.none)
            Button("reset_password_request_reset".localized(userLanguage), action: {
                self.error = nil
                self.isLoading = true
                hideKeyboard()
                sessionManager.resetPassword(username: username) { error in
                    self.isLoading = false
                    self.error = error
                }
            }).authAccent3Button()
            
            Spacer()
            
            Button("confirm_code_return_to_log_in".localized(userLanguage), action: {
                sessionManager.showLogin()
            })
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .background(
          LinearGradient(gradient: Gradient(colors: [ Color("PrimaryColor2"), Color("PrimaryColor")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword(username: "jb")
    }
}
