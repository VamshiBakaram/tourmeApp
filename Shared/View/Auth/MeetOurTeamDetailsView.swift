//
//  MeetOurTeamDetailsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 27/11/23.
//

import SwiftUI

struct MeetOurTeamDetailsView: View {
    var teamDetails: MeetOutTeamModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(colorScheme == .light ? "back (3)" : "back (4)")
                    })
                    Text("Meet TourmeApp’s Team")
                        .font(.custom(.inriaSansRegular, size: 20))
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                ScrollView {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .leading) {
                            Image(teamDetails.avator)
                                .resizable()
                                .frame(width: reader.size.width, height: reader.size.height * 0.44)
                            VStack(alignment: .leading) {
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text(teamDetails.name)
                                        .multilineTextAlignment(.leading)
                                        .font(
                                            .custom(.inriaSansBold, size: 24)
                                        )
                                        .foregroundColor(.white)
                                    Text(teamDetails.description)
                                        .multilineTextAlignment(.leading)
                                        .font(.custom(.inriaSansBold, size: 12, relativeTo: .title2))
                                        .foregroundColor(.white)

                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                        Text(teamDetails.about)
                          .font(
                            .custom(.inriaSansBold, size: 16)
                          )
                          .foregroundColor(colorScheme == .light ? Color(red: 0.28, green: 0.28, blue: 0.28) : Color.white)
                          .padding(.top)
                          .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    MeetOurTeamDetailsView(teamDetails: .init(name: "fbdhbf", description: "fbhbfd", imageName: "1", about: "teamDetails", avator: "meyrav 1"))
}
