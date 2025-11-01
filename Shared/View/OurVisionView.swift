//
//  OurVisionView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 24/11/23.
//

import SwiftUI

struct OurVisionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(colorScheme == .light ? "back (3)" : "back (4)")
                    })
                    Text("Our Vision".localized(userLanguage))
                        .font(.custom(.inriaSansRegular, size: 22))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                ZStack(alignment: .leading) {
                    Image("image_2023")
                    Text("Tourme App Israel")
                        .font(.custom(.inriaSansBold, size: 22))
                        .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                        .frame(alignment: .leading)
                        .padding(.leading, 20)
                        .multilineTextAlignment(.leading)
                }.padding(.horizontal, 20)
                ScrollView {
                    VStack {
                        Text("As people who love The Bible, the Word of God,and the fascinating history of the Jewish people,we have decided to be the first platform that brings all of the above directly to you".localized(userLanguage))
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.custom(.inriaSansBold, size: 16))
                            //.fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 72/255.0, green: 72/255.0, blue: 72/255.0))
                            .padding(.horizontal, 20)
                        ZStack {
                            Image(colorScheme == .dark ? "israel-flag 1" : "Group 37")
                                .resizable()
                                .frame(height: 200)
                            Text("Whether you have visited Israel,\nplanning on visiting Israel,\nor for whatever reason won’t be\nable to visit the Land,\nthe app will connect you with The\nHebrew\nBible and The Greek Text at any\ngiven time.".localized(userLanguage))
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .font(.custom(.inriaSansBold, size: 16))
                                //.fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 72/255.0, green: 72/255.0, blue: 72/255.0))
                                .padding(.horizontal, 20)
                        }
                        Text("Our dream is to spread the word to all four corners of the world. The more people will be exposed to The Word,the closer this will take us to the better world that we all aspire for".localized(userLanguage))
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .font(.custom(.inriaSansBold, size: 16))
                            //.fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 72/255.0, green: 72/255.0, blue: 72/255.0))
                            .padding(.horizontal, 20)
                    }
                }
                .frame(width: reader.size.width)
            }
        }
    }
}

#Preview {
    OurVisionView()
}
