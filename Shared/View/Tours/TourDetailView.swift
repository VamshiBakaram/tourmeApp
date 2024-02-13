//
//  TourDetailView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI
import Amplify

struct TourDetailView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    @ObservedObject var tourViewModel: TourViewModel
    
    @State var isShowingPurchaseMessage = false
    @State var isShowingPurchaseErrorMessage = false
    @State var tour: Tour
    @State var busStops = [BusStop]()
        
    var body: some View {
        
        GeometryReader { proxy in
            
            ScrollView(.vertical) {

                VStack(alignment: .leading) {
                    
                    BCGAsyncImage(url: URL(string: tour.thumbnailUrl)!)
                        .aspectRatio(contentMode: .fit)
                        .overlay(VStack {
                            NavigationLink(
                                destination: 
                                    Text("Start Tour")
                                   // TourPlayerView(tour: tour)
                                ,
                                label: {
                                    Text("Start Tour")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .padding()
                                })
                            //.frame(maxWidth: .infinity)
                            .background(Color("AccentColor3"))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom, -25)
                        }, alignment: .bottomLeading)
                        
                }
                .padding(.bottom, 10)
                
                Text(tour.description ?? "")
                    .padding()
                    .frame(width: proxy.size.width, alignment: .leading)
                
                Group {
                    ForEach(self.busStops, id: \.id) { stop in
                        BusStopListItemView(tapAction: {}, stop: stop, showCompact: proxy.size.width < 500)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(tour.name)
            .onAppear {
                self.busStops.removeAll()
                self.busStops.append(contentsOf: tour.BusStops?.items?.sorted(by: { cur, next in
                    next.name > cur.name
                }) ?? [BusStop]())
            }
            
        }
        
        
    }
}

struct TourDetailView_Previews: PreviewProvider {
    
    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo integer. Egestas maecenas pharetra convallis posuere morbi leo urna molestie. Parturient montes nascetur ridiculus mus mauris. Et tortor consequat id porta nibh venenatis cras sed felis. Tincidunt nunc pulvinar sapien et."
    
    static let tour = Tour(language: "EN",
                           name: "Some Tour",
                           description: lorem,
                           enabled: true,
                           position: GeoPoint(lat: 31.23444, lon: 34.54546),
                           thumbnailUrl: "https://jbsonemanband.com/wp-content/uploads/2020/12/cropped-JBs-One-Man-Band-Logo-Hands-Free-1.png")
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TourDetailView(tourViewModel: TourViewModel(), tour: tour).colorScheme($0)
        }
    }
}
