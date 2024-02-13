//
//  TourListView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI
import Combine
import Amplify
import AWSPluginsCore

struct ToursListView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var tourViewModel: TourViewModel
    @EnvironmentObject var menuData: MenuViewModel
    
    var body: some View {
        Text("fdf")
//        GeometryReader { proxy in
//            
//            if tourViewModel.err != nil {
//                
//                NoInternetView(tourViewModel: tourViewModel)
//                
//            } else {
//                
//                NavigationView {
//                        
//                    if #available(iOS 15.0, *) {
//                        List(tourViewModel.tours, id: \.id) { tour in
//                            TourListItemView(tour: tour, proxy: proxy)
//                        }
//                        .listStyle(PlainListStyle())
//                        .refreshable {
//                            tourViewModel.loadTours(userLanguage: userLanguage)
//                        }
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationTitle("tours_title".localized(userLanguage))
//                        .toolbar {
//                            Button(action: {
//                                tourViewModel.loadTours(userLanguage: userLanguage)
//                            }, label: {
//                                Image(systemName: "arrow.clockwise.circle.fill")
//                            })
//                        }
//                    } else {
//                        List(tourViewModel.tours, id: \.id) { tour in
//                            TourListItemView(tour: tour, proxy: proxy)
//                        }
//                        .listStyle(PlainListStyle())
//                        .navigationBarTitleDisplayMode(.inline)
//                        .navigationTitle("tours_title".localized(userLanguage))
//                    }
//                        
//                    DefaultDetailView()
//                    
//                }
//                .onAppear {
//                    //menuData.navigationText = "Tours"
//                    
//                    if tourViewModel.tours.count == 0 && !tourViewModel.isLoading {
//                        tourViewModel.loadTours(userLanguage: userLanguage)
//                    }
//                    
//                }
//                
//            }
//            
//        }
        
    }
}

struct ToursListView_Previews: PreviewProvider {

    static var tours: [Tour] = [
        Tour(language: "EN", name: "Sample Tour", enabled: true, position: GeoPoint(lat: 31.004, lon: 30.002), thumbnailUrl: "https://tourmeapp.net/wp-content/uploads/elementor/thumbs/tourmeapp_logo_redesign_02-p3l46b1nc03i4bowhb80urf0xehaycgnriz3gt0t1c.png")
    ]

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ToursListView().colorScheme($0)
        }
    }
}
