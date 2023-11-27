//
//  MeetOutTeamView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 27/11/23.
//

import SwiftUI

struct MeetOutTeamView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var meetOutTeamModel: [MeetOutTeamModel] = [.init(name: "Boaz Shalgi", description: "Professional Tour Guide & Bilbe Scholar", imageName: "1"), .init(name: "Zvi Harpaz", description: "3 Decades of Experience in Tour Guide", imageName: "2"), .init(name: "Meyrav Eyal Harpaz", description: "Manger & Marketer", imageName: "3")]
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
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 1000))], alignment: .leading, spacing: 20) {
                        ForEach(meetOutTeamModel) { item in
                            NavigationLink {
                                MeetOurTeamDetailsView(teamDetails: item)
                                    .navigationBarHidden(true)
                            } label: {
                                HStack(alignment: .top) {
                                    Image(item.imageName)
                                        .resizable()
                                        .frame(width: 138, height: 174)
                                        .scaledToFill()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(
                                                .custom(.inriaSansBold, size: 20)
                                            )
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                            .padding(.top, 20)
                                        Text(item.description)
                                            .font(
                                                .custom(.inriaSansBold, size: 14)
                                            )
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                            .padding(.top, -4)
                                        Image("learn more")
                                    }.padding(.horizontal, 12)
                                }
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black.opacity(0.09), radius: 5, x: 2, y: 2)
                                .padding(.horizontal)
                            }

                        }
                    }
                }
                .frame(width: reader.size.width)
                
            }
        }
    }
}

#Preview {
    MeetOutTeamView()
}

struct MeetOutTeamModel: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}
