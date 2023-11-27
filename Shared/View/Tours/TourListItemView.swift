//
//  TourListItemView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI

struct TourListItemView: View {
    
    @EnvironmentObject var tourViewModel: TourViewModel
    
    @State var tour: Tour
    var proxy: GeometryProxy
    
    var body: some View {
        BCGAsyncImage(url: URL(string: tour.thumbnailUrl)!)
            .aspectRatio(contentMode: .fill)
            .frame(height: 215)
            .overlay(
                VStack {
                    Text(tour.name)
                        .font(.custom(.inriaSansRegular, size: 20))
                        .fontWeight(.heavy)
                        .kerning(1.4)
                        .foregroundColor(.white)
                        .padding()
                        .shadow(radius: 5.0)
                    
                }, alignment: .top)
//        if (proxy != nil) {
//            
//        } else {
//            ZStack(alignment: .leading) {
//                NavigationLink(
//                    destination: TourPlayerView(tour: tour)) {
//                    EmptyView()
//                }
//                .opacity(0)
//                .padding(.all, 0)
//                
//                BCGAsyncImage(url: URL(string: tour.thumbnailUrl)!)
//                    .aspectRatio(contentMode: .fill)
//                    .overlay(
//                        VStack {
//                            Text(tour.name)
//                                .font(.largeTitle)
//                                .fontWeight(.heavy)
//                                .kerning(1.4)
//                                .foregroundColor(.white)
//                                .padding(.horizontal)
//                                .shadow(radius: 5.0)
//                                .shadow(radius: 5.0)
//                                .shadow(radius: 5.0)
//                            
//                        }, alignment: .top)
//            }
//        }
        
    }
}

struct TourListItemView_Previews: PreviewProvider {
    static var tour = Tour(language: Language.en, name: "Sample Tour", enabled: true, position: GeoPoint(lat: 31.004, lon: 30.002), thumbnailUrl: "https://tourmeapp.net/wp-content/uploads/elementor/thumbs/tourmeapp_logo_redesign_02-p3l46b1nc03i4bowhb80urf0xehaycgnriz3gt0t1c.png")

    static var previews: some View {
        GeometryReader { reader in
            TourListItemView(tour: tour, proxy: reader)
        }
    }
}
