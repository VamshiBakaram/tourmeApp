//
//  SupportUsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 27/11/23.
//

import SwiftUI

struct SupportUsView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back (3)")
                })
                Text("Support Us")
                    .font(.custom(.inriaSansRegular, size: 20))
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            VStack(alignment: .center) {
                
                Image("tourmeapp_logo")
                    .padding(.top)
                Text("Donate to TourmeApp")
                  .font(
                    .custom(.inriaSansBold, size: 20)
                  )
                  .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                  .padding(.top)
                HStack {
                    Text("$10")
                      .font(
                        Font.custom("Inria Sans", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                      .padding(.horizontal)
                    Rectangle()
                      .frame(width: 1, height: 67)
                      .overlay(
                        Rectangle()
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
                      )
                    Text("$20")
                      .font(
                        Font.custom("Inria Sans", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                      .padding(.horizontal)
                    Rectangle()
                      .frame(width: 1, height: 67)
                      .overlay(
                        Rectangle()
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
                      )
                    Text("$50")
                      .font(
                        Font.custom("Inria Sans", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                      .padding(.horizontal)
                    Rectangle()
                      .frame(width: 1, height: 67)
                      .overlay(
                        Rectangle()
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)
                      )
                    Text("Custom")
                      .font(
                        Font.custom("Inria Sans", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                      .padding(.horizontal)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 1)

                    )
                .padding(.top)
                VStack {
                    HStack {
                        Text("(Optional) Use this donation for")
                          .font(
                            .custom(.inriaSansBold, size: 16)
                          )
                          .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                        Spacer()
                        Image("navigate_next")
                            .frame(width: 20, height: 20)
                    }
                    Divider()
                        .background(Color.gray.opacity(0.5))
                }.padding(.top)
                HStack {
                    Image("check box")
                    Text("Make this a monthly donation")
                      .font(
                        .custom(.inriaSansBold, size: 14)
                      )
                      .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                    Image("help (1)")
                }.padding(.top)
                Button(action: {
                    
                }, label: {
                    Text("Donate with Paypal")
                        .font(.custom(.inriaSansRegular, size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: (.infinity))
                        .frame(height: 50)
                        .background(Color.buttonThemeColor)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.top)
                })
                .padding(.bottom, 20)
                Spacer()
            }.padding(.horizontal)
        }
    }
}

#Preview {
    SupportUsView()
}
