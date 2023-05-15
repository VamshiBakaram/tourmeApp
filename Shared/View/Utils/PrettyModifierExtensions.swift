//
//  PrettyModifierExtensions.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//

import SwiftUI

extension TextField {
    func pretty() -> some View {
        self.padding()
            .background(Color("TextFieldBackground"))
            .cornerRadius(20)
    }
}

extension SecureField {
    func pretty() -> some View {
        self.padding()
            .background(Color("TextFieldBackground"))
            .cornerRadius(20)
    }
}

extension Button {
    func authPrimaryButton() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .foregroundColor(.white)
            .cornerRadius(20)
    }
    
    func authPrimary2Button() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor2"))
            .foregroundColor(.white)
            .cornerRadius(20)
    }
    
    func authPrimary3Button() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor3"))
            .foregroundColor(.white)
            .cornerRadius(20)
    }
    
    func authAccentButton() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.white)
            .cornerRadius(20)
    }
    
    func authAccent3Button() -> some View {
        self.frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color("AccentColor3"))
            .foregroundColor(.black)
            .cornerRadius(20)
    }
}
