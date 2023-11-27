//
//  ToursMapView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/6/21.
//

import SwiftUI
import MapKit

extension Tour: Identifiable {
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: self.position.lat ?? 0.0, longitude: self.position.lon ?? 0.0)
        }
    }
}

struct ToursMapView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var tourViewModel: TourViewModel
    @EnvironmentObject var menuData: MenuViewModel

//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.00268353309836, longitude: 34.86694867125039), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.79, longitude: 35.09), span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Maps")
                .font(.custom(.inriaSansBold, size: 20))
                .padding(.horizontal)
                .padding(.vertical, 4)
            if tourViewModel.error != nil {
                NoInternetView(tourViewModel: tourViewModel)
             } else {
                 Map(coordinateRegion: $region, annotationItems: tourViewModel.tours) { tour in
                     MapAnnotation(coordinate: tour.coordinate) {
                         MapPinImage()
                             .onTapGesture {
                                 tourViewModel.selectedTour = tour
                                 tourViewModel.isShowingSelectedTour = true
                             }
                     }
                 }
                 /*
                 .navigationBarTitleDisplayMode(.inline)
                 .navigationTitle("maps_title".localized(userLanguage))
                 .toolbar {
                     Button(action: {
                         tourViewModel.loadTours(userLanguage: userLanguage)
                     }, label: {
                         Image(systemName: "arrow.clockwise.circle.fill")
                     })
                 }
                  */
                 .overlay(
                     
                     ZStack {
                         if tourViewModel.isShowingSelectedTour {
                             TourPlayerView(tour: tourViewModel.selectedTour!)
                         }
                     }
                 )
                .onAppear {
                    MKMapView.appearance().mapType = .hybrid
                    
                    if tourViewModel.tours.count == 0 && !tourViewModel.isLoading {
                        tourViewModel.loadTours(userLanguage: userLanguage)
                    }
                }
            }
        }
    }
        
}

struct ToursMapView_Previews: PreviewProvider {
    static var previews: some View {
        ToursMapView()
    }
}
