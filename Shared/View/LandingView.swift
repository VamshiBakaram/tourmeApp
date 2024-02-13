//
//  LandingView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 9/5/22.
//

import SwiftUI
import AVKit

struct HomeItemModel: Identifiable {
    let id = UUID()
    let iconName: String
    let optionName: String
    let bg: String
    let title: String
}

struct LandingView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var tourViewModel: TourViewModel
    @EnvironmentObject var menuData: MenuViewModel
    
    @StateObject var homeContentViewModel = HomeContentViewModel()
    
    @State private var currentPage = 0
    @State private var showingBioSheetZvi = false
    @State private var showingBioSheetMeyrav = false
    @State private var showingBioSheetBoaz = false
    
    @State var homeItems: [HomeItemModel] = [
        .init(iconName: "title1", optionName: "Vision", bg: "bg1", title: "Our"), .init(iconName: "title2", optionName: "Our Team", bg: "bg2", title: "Meet"), .init(iconName: "title3", optionName: "Your Tour", bg: "bg3", title: "Choose"), .init(iconName: "title4", optionName: "Event", bg: "bg4", title: "Special"), .init(iconName: "title5", optionName: "Us", bg: "bg5", title: "Support")
    ]
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    Image("tourmeapp_logo home")
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: 0) {
                            ForEach(homeItems) { item in
                                NavigationLink {
                                    if item.optionName == "Vision" {
                                        OurVisionView()
                                            .navigationBarHidden(true)
                                    }
                                    if item.optionName == "Our Team" {
                                        MeetOutTeamView()
                                            .navigationBarHidden(true)
                                    }
                                    if item.optionName == "Event" {
                                        SpecialEventsView()
                                            .navigationBarHidden(true)
                                    }
                                    if item.optionName == "Us" {
                                        SupportUsView()
                                            .navigationBarHidden(true)
                                    }
                                       
                                } label: {
                                        HStack(alignment: .center) {
                                            Image(item.iconName)
                                                .padding(.top, 40)
                                                .padding(.leading, 26)
                                                .padding(.bottom, 40)
                                            VStack(alignment: .leading) {
                                                Text(item.title.localized(userLanguage))
                                                    .font(.custom(.inriaSansRegular, size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    .padding(.horizontal, 12)
                                                Text(item.optionName.localized(userLanguage))
                                                    .font(.custom(.inriaSansRegular, size: 26))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.white)
                                                    //.padding(.bottom, 20)
                                                    .padding(.horizontal, 12)
                                            }
                                            Spacer()
                                            Image("arrow")
                                                .padding()
                                        }
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.01), radius: 5, x: 2, y: 2)
                                        .padding(.horizontal, 20)
                                        .background(
                                            Image(item.bg)
                                                .resizable()
                                                .clipped()
                                        )
                                }

                            }
                        }
                    }
                }
            }
            .background(colorScheme == .light ? Color(red: 0.98, green: 0.98, blue: 0.98) : Color.black)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LandingView().colorScheme($0)
        }
    }
}

