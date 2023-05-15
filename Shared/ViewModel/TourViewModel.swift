//
//  TourModel.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import Combine
import Amplify
import AWSPluginsCore
import SwiftUI

struct TourSubtitles {
    var tourId: String
    var videoSubtitles: [VideoSubtitles]?
}

struct VideoSubtitles {
    var videoId: String
    var urls: [URL]?
}

class TourViewModel: ObservableObject {
    
    @AppStorage("userLanguage") var userLanguage: Language = Language.en
        
    @Published var isLoading = false
    @Published var tours: [Tour] = [Tour]()
    @Published var error: Error?
    @Published var tourSubtitles: [TourSubtitles] = [TourSubtitles]()
    @Published var selectedTour: Tour? = nil
    @Published var isShowingSelectedTour: Bool = false
    
    func loadTours(userLanguage: Language) {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://d3aa37cj97ghel.cloudfront.net/tours_\(userLanguage.rawValue).json") else {
                    return
                }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let toursData = try JSONDecoder().decode([Tour].self, from: data)
                        DispatchQueue.main.async {
                            self.tours = toursData
                            
                            self.tours.sort { cur, next in
                                next.sortOrder ?? 0 > cur.sortOrder ?? 0
                            }
                            
                            self.isLoading = false
                        }
                    } catch let error {
                        print("Error: \(error)")
                        DispatchQueue.main.async {
                            self.error = error
                            self.isLoading = false
                        }
                    }
                }.resume()
        
    }
    
    /*
    func loadTours(userLanguage: Language) {
        
        self.isLoading = true
        
        let listTours = """
            query listActiveToursEn {
              listTours(filter: {language: {eq: \(userLanguage.rawValue)}, enabled: {eq: true}}) {
                items {
                  id
                  name
                  language
                  enabled
                  position {
                    lon
                    lat
                  }
                  thumbnailUrl
                  videoUrl
                  description
                  sortOrder
                  BusStops(filter: {enabled: {eq: true}, language: {eq: \(userLanguage.rawValue)}}) {
                    items {
                      enabled
                      description
                      name
                      id
                      thumbnailUrl
                      videoUrl
                      language
                    }
                  }
                }
              }
            }


            """
        
        let request = GraphQLRequest(document: listTours, responseType: [Tour].self, decodePath: "listTours.items")
        
        Amplify.API.query(request: request) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let data):
                    print("Successfully retrieved list of tours: \(data)")
                                        
                    DispatchQueue.main.async {
                        self.tours = data
                        self.tours.sort { cur, next in
                            next.sortOrder ?? 0 > cur.sortOrder ?? 0
                        }
                        
                        //self.loadSubtitles()
                        
                        self.isLoading = false
                    }
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    DispatchQueue.main.async {
                        self.error = error
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
     */
    
    
    func loadSubtitles() {
        self.tours.forEach { tour in
            print(tour.name)
            
        }
    }

}
