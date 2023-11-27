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
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("back (3)")
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
                            Image(teamDetails.imageName)
                                .resizable()
                                .frame(width: reader.size.width, height: 328)
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
                                        .font(.custom(.inriaSansBold, size: 12))
                                        .foregroundColor(.white)

                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                        Text("I have been a professional tour guide and a Bible\nscholar since 1995. I am a direct descendant of the\nholy tribe of Levi. I was born and raised in Jerusalem,\nwhere I spent endless hours roaming the cobblestone\npaths of the old city and discovering every hidden\npearl.\n\nI now live in Galilee, another spectacular and holy \nplace, where the green fields call to me and whisper\nthe stories of ancient times, which I can't wait to\nshare with you.")
                          .font(
                            .custom(.inriaSansBold, size: 14)
                          )
                          .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                          .padding(.top)
                          .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    MeetOurTeamDetailsView(teamDetails: .init(name: "fbdhbf", description: "fbhbfd", imageName: "1"))
}
