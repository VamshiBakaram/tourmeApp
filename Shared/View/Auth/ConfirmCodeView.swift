//
//  ConfirmCodeView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//

import SwiftUI
import Amplify

struct ConfirmCodeView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var confirmationCode = ""
    
    @State var isLoading = false
    @State var error: Error?
    
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
                Button("confirm_code_confirm".localized(userLanguage), action: {
                    self.error = nil
                    self.isLoading = true
                    hideKeyboard()
                    sessionManager.confirm(username: username, code: confirmationCode) { error in
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
}

struct ConfirmCodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        ConfirmCodeView(username: "jb")
            .environmentObject(SessionManager())
    }
}
