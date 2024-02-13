//
//  LogoutView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 09/01/24.
//

import SwiftUI

struct LogoutView: View {
    
    @Binding var isCancel: Bool
    @EnvironmentObject var sessionManager: SessionManager
    @AppStorage("displayName") var userDisplayName = ""
    
    var body: some View {
        VStack {
            Text("Sign Out?")
              .font(
                .custom(.inriaSansBold, size: 20)
              )
              .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
              .padding(.vertical, 8)
              .padding(.top, 20)
            Text("Are you sure you want to sign out?")
              .font(
                .custom(.inriaSansBold, size: 16)
              )
              .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
            HStack(spacing: 20) {
                Button(action: {
                    isCancel = false
                }, label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(
                            .custom(.inriaSansBold, size: 18)
                        )
                        .foregroundColor(Color(red: 0.95, green: 0.42, blue: 0.11))
                        .background(.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.95, green: 0.42, blue: 0.11), lineWidth: 1)
                        )
                })
                
                Button(action: {
                    sessionManager.userId = ""
                    sessionManager.email = ""
                    sessionManager.displayName = ""
                    sessionManager.displayName = ""
                    userDisplayName = ""
                    sessionManager.authManager = "login"
                }, label: {
                    Text("Sign out")
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .font(
                            .custom(.inriaSansBold, size: 18)
                        )
                        .foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))
                        .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                        .cornerRadius(5)
                })
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
        }
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
        .padding(.all, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
        .edgesIgnoringSafeArea(.all)
    }
}


