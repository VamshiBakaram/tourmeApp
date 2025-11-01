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
    //@Published var tours: [Tour] = [Tour]()
    @Published var error: Error?
    @Published var tourSubtitles: [TourSubtitles] = [TourSubtitles]()
    @Published var selectedTour: Tour? = nil
    @Published var isShowingSelectedTour: Bool = false
    
    
    func getTours() {
     
        NetworkManager.shared.request(type: ToursModel.self, url: API.tours,isTokenRequired: true) { [weak self]result in
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
    func loadSubtitles() {
//        self.tours.forEach { tour in
//            print(tour.name)
//
//        }
    }
    

}

//struct ToursModel: Decodable {
//    let data: [ToursDataModel]?
//}
//
//struct ToursDataModel: Decodable, Identifiable {
//    let id = UUID().uuidString
//    let tourID: Int?
//    let tourName, tourImage, tourDescription: String?
//    let imageURLPath: String?
//    let videoCount: Int?
//    let latitude: String?
//    let langitude: String?
//
//    enum CodingKeys: String, CodingKey {
//        case tourID = "tourId"
//        case tourName, tourImage, tourDescription
//        case imageURLPath = "imageUrlPath"
//        case videoCount
//        case latitude, langitude
//    }
//}

struct ToursModel: Decodable {
    let status: String?
    let message, errorCode, errorMessage: String?
    let data: [ToursDataModel]?

    enum CodingKeys: String, CodingKey {
        case status, message
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case data
    }
}

struct ToursDataModel: Decodable, Identifiable {
    let id = UUID().uuidString
    let tourID: Int?
    let tourImage: String?
    let imageURLPath: String?
    let tourVideo: String?
    let videoURLPath: String?
    let sPTourVideo: String?
    let sPVideoURLPath: String?
    let pOTourVideo: String?
    let pOVideoURLPath: String?
    let eNDuration, sPDuration, pODuration: String?
    let tourName, tourDescription, sPTourName, sPTourDescription: String?
    let pOTourName, pOTourDescription, latitude, langitude: String?
    let isActive: Bool?
    let videoCount: Int?

    enum CodingKeys: String, CodingKey {
        case tourID = "tourId"
        case tourImage
        case imageURLPath = "imageUrlPath"
        case tourVideo
        case videoURLPath = "videoUrlPath"
        case sPTourVideo = "sP_TourVideo"
        case sPVideoURLPath = "sP_VideoUrlPath"
        case pOTourVideo = "pO_TourVideo"
        case pOVideoURLPath = "pO_VideoUrlPath"
        case eNDuration = "eN_Duration"
        case sPDuration = "sP_Duration"
        case pODuration = "pO_Duration"
        case tourName, tourDescription
        case sPTourName = "sP_TourName"
        case sPTourDescription = "sP_TourDescription"
        case pOTourName = "pO_TourName"
        case pOTourDescription = "pO_TourDescription"
        case latitude, langitude, isActive, videoCount
    }
}

