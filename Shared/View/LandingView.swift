//
//  LandingView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 9/5/22.
//

import SwiftUI
import AVKit

struct LandingView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var tourViewModel: TourViewModel
    @EnvironmentObject var menuData: MenuViewModel
    
    @StateObject var homeContentViewModel = HomeContentViewModel()
    
    @State private var currentPage = 0
    @State private var showingBioSheetZvi = false
    @State private var showingBioSheetMeyrav = false
    @State private var showingBioSheetBoaz = false
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ScrollView {
                
                Image("tourmeapplogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(0)
                
                if (tourViewModel.tours.count > 0) {
                    Text("Featured Tour")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                        .padding(.bottom, -10)
                        .foregroundColor(Color("PrimaryColor2"))
                    
                    TourListItemView(tour: tourViewModel.tours.prefix(tourViewModel.tours.count-2).randomElement()!, proxy: proxy)
                        .onTapGesture {
                            menuData.selectedMenu = .tours
                        }
                }
                
                Text("Latest Tours")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                    .padding(.bottom, -10)
                    .foregroundColor(Color("PrimaryColor2"))
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(tourViewModel.tours.reversed().filter({ tour in
                            tour.sortOrder ?? 0 < 30
                        }).prefix(3), id: \.id) { tour in
                            TourListItemView(tour: tour, proxy: proxy)
                                .onTapGesture {
                                    menuData.selectedMenu = .tours
                                }
                        }
                    }
                }
                
                Text("Meet the Team")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                    .padding(.bottom, -10)
                    .foregroundColor(Color("PrimaryColor2"))
                
                ScrollView(.horizontal) {
                    HStack {
                        VStack {
                            Image("zvi")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                            Text("Zvi Harpaz")
                                .font(.headline)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .onTapGesture {
                            showingBioSheetZvi.toggle()
                        }
                        
                        VStack {
                            Image("meyrav")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                            Text("Meyrav Harpaz")
                                .font(.headline)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .onTapGesture {
                            showingBioSheetMeyrav.toggle()
                        }
                        
                        VStack {
                            Image("boaz")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                            Text("Boaz Shalgi")
                                .font(.headline)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .onTapGesture {
                            showingBioSheetBoaz.toggle()
                        }
                    }
                }
            }
            .onAppear {
                if tourViewModel.tours.count == 0 && !tourViewModel.isLoading {
                    tourViewModel.loadTours(userLanguage: userLanguage)
                }
            }
            .sheet(isPresented: $showingBioSheetZvi) {
                        BioView(imageName: "zvi", title: "Zvi Harpaz", description: "I have been a tour guide in Israel for over 32 years and my in-depth knowledge and love of the land bring you a fascinating perspective. I am fluent in Hebrew, English, Spanish, Portuguese, French and also a bit of Mandarin Chinese. My happiest moments are spent showing this land to people that yearn to see it love it as much as I do! I am also a helicopter and airplane pilot so I can show you Israel from the bird’s eye view…")
                    }
            .sheet(isPresented: $showingBioSheetMeyrav) {
                        BioView(imageName: "meyrav", title: "Meyrav Harpaz", description: "After years of managing and marketing our unique tours in Israel... I was realized that millions want to come here and were unable to, so I came up with a vision to bring the Holy Land to them - and TourMeApp was born. I see this not only as a temporary solution to reinvigorate the travel industry - I see this as a mission - to help the millions of people around the world who are unable to physically visit the holy land to experience the Land as if they were here in person.")
                    }
            .sheet(isPresented: $showingBioSheetBoaz) {
                        BioView(imageName: "boaz", title: "Boaz Shalgi", description: "I have been a professional tour guide and a bible scholar since 1995. I am a direct descendant of the holy tribe of Levi. I was born and raised in Jerusalem, where I spent endless hours roaming the cobblestone paths of the Old City and discovering every hidden pearl. I now live in the Galilee, another spectacular and holy place - where the green fields call to me all the time and whisper the stories of ancient times - which I can’t wait to share with you!")
                    }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LandingView().colorScheme($0)
        }
    }
}

