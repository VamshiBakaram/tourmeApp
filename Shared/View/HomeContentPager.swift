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
        VStack(alignment: .leading) {
            Text("News")
                .font(.custom(.inriaSansBold, size: 20))
                .padding(.horizontal)
                .padding(.vertical, 4)
            if homeContentViewModel.error != nil {
                NoInternetHomeContentView(homeContentViewModel: homeContentViewModel)
            } else {
                PagerView(pageCount: homeContentViewModel.homeContent.count, currentIndex: $currentPage) {
                    ForEach(homeContentViewModel.homeContent, id: \.id) { item in
                        HomeContentItemView(homeContent: item, currentIndex: currentPage)
                    }
                }
                .onAppear {
                    homeContentViewModel.loadHomeContent(userLanguage: userLanguage)
                }
                
            }
        }.overlay(
            HStack(spacing: 5) {
                ForEach(0..<3) { index in
                    Capsule()
                        .fill(currentPage == index ? Color(red: 0.02, green: 0.62, blue: 0.85) : Color.gray)
                        .frame(width: currentPage == index ? 20 : 7, height: 7)
                }
            }
            .padding(.bottom)
            , alignment: .bottom)
        
    }
}

/*
struct HomeContentPager_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentPager()
    }
}
 */
