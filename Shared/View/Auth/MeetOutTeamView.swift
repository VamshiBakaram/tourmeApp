//
//  MeetOutTeamView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 27/11/23.
//

import SwiftUI

struct MeetOutTeamView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @State var meetOutTeamModel: [MeetOutTeamModel] = [.init(name: "Boaz Shalgi", description: "Professional Tour Guide & Bilbe Scholar", imageName: "Rectangle 164 (1)", about: "I have been a professional tour guide and a Bible scholar since 1995. I am a direct descendant of the holy tribe of Levi. I was born and raised in Jerusalem,where I spent endless hours roaming the cobblestone paths of the old city and discovering every hidden pearl.\n\nI now live in Galilee, another spectacular and holy place, where the green fields call to me and whisper the stories of ancient times, which I can't wait to share with you.", avator: "Rectangle 164 (1)"), .init(name: "Zvi Harpaz", description: "3 Decades of Experience in Tour Guide", imageName: "2", about: "I have been a tour guide in Israel for over 32 years and my in-depth knowledge and love of the land bring you a fascinating perspective. I am fluent in Hebrew, English, Spanish, Portuguese, French and also a bit of Mandarin Chinese. My happiest moments are spent showing this land to people that yearn to see it love it as much as I do! I am also a helicopter and airplane pilot so I can show you Israel from the bird’s eye view.", avator: "zvi 1"), .init(name: "Meyrav Eyal Harpaz", description: "Manager & Marketer", imageName: "3", about: "After years of managing and marketing our unique tours in Israel… I realized that millions want to come here and were unable to, so I came up with a vision to bring the Holy Land to them - and TourMeApp was born. I see this not only as a temporary solution to reinvigorate the travel industry - I see this as a mission - to help the millions of people around the world who are unable to physically visit the holy land to experience the Land as if they were here in person.", avator: "meyrav 1")]
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(colorScheme == .light ? "back (3)" : "back (4)")
                    })
                    Text("Meet TourmeApp’s Team".localized(userLanguage))
                        .font(.custom(.inriaSansRegular, size: 22))
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
                                        .frame(width: 159, height: 185)
                                        .scaledToFill()
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(
                                                .custom(.inriaSansBold, size: 22)
                                            )
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                            .padding(.top, 20)
                                        Text(item.description)
                                            .font(
                                                .custom(.inriaSansBold, size: 16)
                                            )
                                            .multilineTextAlignment(.leading)
                                            .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                                            .padding(.top, -4)
                                        Image("learn more")
                                    }.padding(.horizontal, 12)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .background(colorScheme == .light ? Color.white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .black.opacity(0.09), radius: 5, x: 2, y: 2)
                                .padding(.horizontal, 20)
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
    let about: String
    let avator: String
}
