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
    
    init() {
        self.isShowIndicator = true
        self.getTours()
    }
    
    @Published var isShowIndicator = false
    @Published var errorMessage: String?
    @Published var toursList: [ToursDataModel] = []
    
    
    @AppStorage("userLanguage") var userLanguage: Language = Language.en
        
    @Published var isLoading = false
    @Published var tours: [Tour] = [Tour]()
    @Published var error: Error?
    @Published var tourSubtitles: [TourSubtitles] = [TourSubtitles]()
    @Published var selectedTour: Tour? = nil
    @Published var isShowingSelectedTour: Bool = false
    
    
    func getTours() {
        NetworkManager.shared.request(type: ToursModel.self, url: API.tours) { [weak self]result in
            guard let self = self else { return }
            self.isShowIndicator = false
            switch result {
            case .success(let response):
                self.toursList = response.data ?? []
                break
            case .failure(let error):
                switch error {
                case .message(message: let message):
                    self.errorMessage = message
                case .error(error: let error):
                    self.errorMessage = error
                }
            }
        }
    }
    
    func loadTours(userLanguage: Language) {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://d3aa37cj97ghel.cloudfront.net/tours_EN.json") else {
                    return
                }
        print("tour url", url)
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        print("tour data", json)
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
    func loadSubtitles() {
        self.tours.forEach { tour in
            print(tour.name)
            
        }
    }
    

}

struct ToursModel: Decodable {
    let data: [ToursDataModel]?
}

struct ToursDataModel: Decodable, Identifiable {
    let id = UUID().uuidString
    let tourID: Int?
    let tourName, tourImage, tourDescription: String?
    let imageURLPath: String?
    let videoCount: Int?

    enum CodingKeys: String, CodingKey {
        case tourID = "tourId"
        case tourName, tourImage, tourDescription
        case imageURLPath = "imageUrlPath"
        case videoCount
    }
}
