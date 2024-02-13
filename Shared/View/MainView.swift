//
//  MainView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI
import UIKit
import Amplify

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme

    init() {
        if #available(iOS 15.0, *) {
            
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor.white
//
//            UITabBar.appearance().standardAppearance = appearance
//            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
            //UITabBar.appearance().barTintColor = (colorScheme == .dark ? UIColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1) : UIColor.white)
            if #available(iOS 13.0, *) {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    UITabBar.appearance().unselectedItemTintColor = .white
                    UITabBar.appearance().backgroundColor = UIColor(displayP3Red: 72/255, green: 72/255, blue: 72/255, alpha: 1)
                }
                else {
                    UITabBar.appearance().unselectedItemTintColor = .black
                    UITabBar.appearance().backgroundColor = UIColor.white
                }
            }
            //UITabBar.appearance().tintColor = UIColor.red
        }
    }
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var sessionManager: SessionManager
    
    //let user: AuthUser
    
    @StateObject var menuData = MenuViewModel()
    @StateObject var userPreferencesStore = UserPreferencesStore()
    @StateObject var tourViewModel = TourViewModel()
    @StateObject var homeContentViewModel = HomeContentViewModel()
    
    var body: some View {
        
        TabView(selection: $menuData.selectedMenu) {
            LandingView()
                .tabItem {
                    Image("home")
                        .renderingMode(.template)
                    Text("toolbar_home".localized(userLanguage))
                }
                .tag(MenuItem.newHome)
            ToursMapView()
                .tabItem {
                    Image("map")
                        .renderingMode(.template)
                    Text("toolbar_map".localized(userLanguage))
                }
                .tag(MenuItem.map)
            ToursGridView()
                .tabItem {
                    Image("tour")
                        .renderingMode(.template)
                    Text("toolbar_tours".localized(userLanguage))
                }
                .tag(MenuItem.tours)
            HomeContentPager(homeContentViewModel: homeContentViewModel)
                .tabItem {
                    Image("news")
                        .renderingMode(.template)
                    Text("toolbar_news".localized(userLanguage))
                }
                .tag(MenuItem.home)
            
            /*
            ToursListView()
                .tabItem {
                    Image(systemName: "list.triangle")
                    Text("toolbar_tours".localized(userLanguage))
                }
                .tag(MenuItem.tours)
             */
            
            /*
            LiveStreamView()
                .tabItem {
                    Image(systemName: "play.tv")
                    Text("toolbar_live".localized(userLanguage))
                }
                .tag(MenuItem.live)
             */
            
            SettingsView()
                .tabItem {
                    Image("more")
                        .renderingMode(.template)
                    Text("toolbar_more".localized(userLanguage))
                }
                .tag(MenuItem.settings)
            
        }
        
        // Setting as Environment Object...
        .environmentObject(menuData)
        //.environmentObject(sessionManager)
        .environmentObject(userPreferencesStore)
        .environmentObject(tourViewModel)
        .onAppear(perform: {
            
        })
        //.preferredColorScheme(ColorScheme.dark)
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            //MainView(user: DummyUser()).colorScheme($0)
            MainView().colorScheme($0)
        }
    }
}
