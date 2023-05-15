//
//  ToursGridView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/16/22.
//

import SwiftUI
import Amplify
import AWSPluginsCore

struct ToursGridView: View {
        
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @EnvironmentObject var menuData: MenuViewModel
    @EnvironmentObject var tourViewModel: TourViewModel
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 16)], spacing: 16) {
                    
                    ForEach(tourViewModel.tours, id: \.id) { tour in
                        
                        TourListItemView(tour: tour)
                            .cornerRadius(10)
                            .onTapGesture {
                                tourViewModel.selectedTour = tour
                                tourViewModel.isShowingSelectedTour = true
                            }
                    }
                    
                }
                .refreshable {
                    tourViewModel.loadTours(userLanguage: userLanguage)
                }
            }
            .overlay(
                
                ZStack {
                    if tourViewModel.isShowingSelectedTour {
                        TourPlayerView(tour: tourViewModel.selectedTour!)
                    }
                }
            )
            .padding(16)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            
            if tourViewModel.tours.count == 0 && !tourViewModel.isLoading {
                tourViewModel.loadTours(userLanguage: userLanguage)
            }
        }
        //.edgesIgnoringSafeArea(.all)
        
    }
}

struct ToursGridView_Previews: PreviewProvider {
    static var previews: some View {
        ToursGridView()
    }
}
