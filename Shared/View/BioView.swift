//
//  BioView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 10/13/22.
//

import SwiftUI

struct BioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
                Text(title)
                    .foregroundColor(Color("PrimaryColor"))
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.4)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .kerning(1.2)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Dismiss")
                        .foregroundColor(.black)
                        .font(.headline)
                        .kerning(1.2)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .background(Color("AccentColor3"))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, -25)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.top, 20)
    }
}
