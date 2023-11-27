//
//  MainView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI
import Amplify

struct MainView: View {
    
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
            
            SettingsView(tourViewModel: tourViewModel)
                .tabItem {
                    Image("more")
                        .renderingMode(.template)
                    Text("toolbar_more".localized(userLanguage))
                }
                .tag(MenuItem.settings)
            
        }.background(Color.white)
        
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
