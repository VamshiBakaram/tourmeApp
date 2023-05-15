//
//  SignUpView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//

import SwiftUI
import Amplify

struct SignUpView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var givenName = ""
    @State var familyName = ""
    
    @State var isLoading = false
    @State var error: Error?
    
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
                
                Group {
                    if self.error != nil {
                        let e = error as? AuthError
                        Text(e?.errorDescription ?? "login_sign_up_failed".localized(userLanguage))
                            .foregroundColor(.white)
                    }
                    TextField("signup_email".localized(userLanguage), text: $email)
                        .pretty()
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("signup_given_name".localized(userLanguage), text: $givenName).pretty()
                    TextField("signup_family_name".localized(userLanguage), text: $familyName).pretty()
                    SecureField("signup_password".localized(userLanguage), text: $password).pretty()
                }
                Button("signup_sign_up".localized(userLanguage), action: {
                    self.error = nil
                    self.isLoading = true
                    hideKeyboard()
                    sessionManager.signUp(username: email, password: password, email: email, givenName: givenName, familyName: familyName) { error in
                        self.isLoading = false
                        self.error = error
                    }
                }).authAccent3Button()
                
                Spacer()
                Button("signup_already_have_an_account_login".localized(userLanguage), action: {
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
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionManager())
    }
}
