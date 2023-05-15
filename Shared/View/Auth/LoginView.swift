//
//  LoginView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//

import SwiftUI
import Amplify

struct LoginView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
    @State var password = ""
    @State var isLoading = false
    @State var error: Error?
    
    var body: some View {
        
        VStack() {
            if isLoading {
                Spacer()
                
                Text("login_please_wait".localized(userLanguage))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                
                Spacer()
            } else {
                
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
                    Text(e?.errorDescription ?? "login_sign_in_failed".localized(userLanguage))
                        .foregroundColor(.white)
                }
                
                TextField("login_username".localized(userLanguage), text: $username)
                    .pretty()
                    .autocapitalization(.none)
                SecureField("login_password".localized(userLanguage), text: $password).pretty()
                
                Button("login_login".localized(userLanguage), action: {
                    self.error = nil
                    self.isLoading = true
                    hideKeyboard()
                    sessionManager.login(username: username, password: password) { error in
                        self.isLoading = false
                        self.error = error
                    }
                })
                    .authAccent3Button()
                
                Button("login_forgot_password".localized(userLanguage), action: sessionManager.showResetPassword)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button("login_dont_have_an_account_sign_up".localized(userLanguage), action: sessionManager.showSignUp)
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .background(
          LinearGradient(gradient: Gradient(colors: [ Color("PrimaryColor2"), Color("PrimaryColor")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionManager())
    }
}
