//
//  DeleteAccView.swift
//  tourmeapp
//
//  Created by Ahex-Guest on 10/10/24.
//

import SwiftUI

struct DeleteAccView: View {
    @Binding var isCancel: Bool
    @EnvironmentObject var sessionManager: SessionManager
    @AppStorage("displayName") var userDisplayName = ""
    @AppStorage("userLanguage") var userLanguage: Language = Language.en
    @State var isShowLogIn = false
    @ObservedObject var deleteAccViewModel = DeleteAccViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                Text("Delete Account".localized(userLanguage))
                  .font(
                    .custom(.inriaSansBold, size: 20)
                  )
                  .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                  .padding(.vertical, 8)
                  .padding(.top, 20)
                Text("Are you sure you want to delete your account?".localized(userLanguage))
                  .font(
                    .custom(.inriaSansBold, size: 16)
                  )
                  .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                HStack(spacing: 20) {
                    Button(action: {
                        isCancel = false
                    }, label: {
                        Text("Cancel".localized(userLanguage))
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
                        deleteAccViewModel.deleteAcc { data in
                            if data.status == "Success"{
                                sessionManager.authManager = "login"
                                isShowLogIn = true
                            }
                        }
                    }, label: {
                        Text("Delete".localized(userLanguage))
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
            
            if isShowLogIn {
                LoginView()
            }
        }
        .toast($deleteAccViewModel.errorMessage)
    }
}


struct DeleteAccModel: Decodable {
    let status:String?
    let message: String?
    let errorCode, errorMessage: String?
  //  let data:String?
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case errorCode = "error_code"
        case errorMessage = "error_message"
      //  case data
    }
}
