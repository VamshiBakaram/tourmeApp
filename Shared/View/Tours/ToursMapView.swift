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

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.00268353309836, longitude: 34.86694867125039), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 31.79, longitude: 35.09), span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Maps".localized(userLanguage))
                    .font(.custom(.inriaSansBold, size: 20))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                if tourViewModel.error != nil {
                    NoInternetView(tourViewModel: tourViewModel)
                 } else {
                     Map(coordinateRegion: $region, annotationItems: tourViewModel.toursList) { tour in
                         MapAnnotation(coordinate: coordinate(for: tour)) {
                             NavigationLink {
                                 NavigationLazyView(TourPlayerView(tourId: tour.tourID ?? 0, titleFrom: tour.tourName ?? "", descriptionFrom: tour.tourDescription ?? ""))
                                     .navigationBarHidden(true)
                             } label: {
                                 MapPinImage()
//                                     .onTapGesture {
//                                         tourViewModel.selectedTour = tour
                                         //tourViewModel.isShowingSelectedTour = true
                                    // }
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
                                 //TourPlayerView(tour: tourViewModel.selectedTour!)
                             }
                         }
                     )
                    .onAppear {
                        MKMapView.appearance().mapType = .hybrid
                        
                        tourViewModel.loadTours(userLanguage: userLanguage)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    func coordinate(for tour: ToursDataModel) -> CLLocationCoordinate2D {
//           if tour.pOTourName?.trimmingCharacters(in: .whitespacesAndNewlines) == "Jaffa" {
//               return CLLocationCoordinate2D(latitude: 32.0496, longitude: 34.7588)
//           } else {
               return CLLocationCoordinate2D(
                   latitude: CLLocationDegrees(Double(tour.latitude ?? "0.0") ?? 0.0),
                   longitude: CLLocationDegrees(Double(tour.langitude ?? "0.0") ?? 0.0)
               )
//           }
       }
        
}

struct ToursMapView_Previews: PreviewProvider {
    static var previews: some View {
        ToursMapView()
    }
}
