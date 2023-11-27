//
//  OurVisionView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 24/11/23.
//

import SwiftUI

struct OurVisionView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("back (3)")
                    })
                    Text("Our Vision")
                        .font(.custom(.inriaSansRegular, size: 20))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                ScrollView {
                    Text("As people who love The Bible, the\nWord of God,\nand the fascinating history of the\nJewish people,\nwe have decided to be the first\nplatform that brings\nall of the above directly to you.\n\nWhether you have visited Israel,\nplanning on visiting Israel,\nor for whatever reason won’t be\nable to visit the Land,\nthe app will connect you with The\nHebrew\nBible and The Greek Text at any\ngiven time.\n\nOur dream is to spread the word to\nall four corners of the world.\nThe more people will be exposed to\nThe Word,\nthe closer this will take us to the\nbetter world that we all aspire for")
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(.custom(.inriaSansRegular, size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                }
                .frame(width: reader.size.width)
            }
        }
    }
}

#Preview {
    OurVisionView()
}
