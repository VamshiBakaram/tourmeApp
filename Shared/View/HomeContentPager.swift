//
//  HomeContentPager.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 10/22/21.
//

import SwiftUI

struct HomeContentPager: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    //@EnvironmentObject var sessionManager: SessionManager
    //@EnvironmentObject var userPreferencesStore: UserPreferencesStore
    @EnvironmentObject var menuData: MenuViewModel
    
    @State private var currentPage = 0
    
    @ObservedObject var homeContentViewModel: HomeContentViewModel
        
    var body: some View {
        
        if homeContentViewModel.error != nil {
            
            NoInternetHomeContentView(homeContentViewModel: homeContentViewModel)
            
        } else {
         
            PagerView(pageCount: homeContentViewModel.homeContent.count, currentIndex: $currentPage) {
                ForEach(homeContentViewModel.homeContent, id: \.id) { item in
                    HomeContentItemView(homeContent: item)
                }
            }
            .onAppear {
                homeContentViewModel.loadHomeContent(userLanguage: userLanguage)
            }
            
        }
        
    }
}

/*
struct HomeContentPager_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentPager()
    }
}
 */
