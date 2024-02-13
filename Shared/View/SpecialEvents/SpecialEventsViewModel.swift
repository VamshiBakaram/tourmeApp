//
//  SpecialEventsViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import Foundation

class SpecialEventsViewModel: ObservableObject {
    
    init() {
        isShowIndicator = true
        getSpecialEvents()
    }
    
    @Published var isShowIndicator = false
    @Published var errorMessage: String?
    
    @Published var specialEvents: [SpecialEventsDataModel] = []
    
    
    func getSpecialEvents() {
        NetworkManager.shared.request(type: SpecialEventsModel.self, url: API.specialEvents, isTokenRequired: true) { [weak self]result in
            guard let self = self else { return }
            self.isShowIndicator = false
            switch result {
            case .success(let response):
                self.specialEvents = response.data ?? []
            case .failure(let error):
                switch error {
                case .message(message: let message):
                    errorMessage = message
                case .error(error: let error):
                    errorMessage = error
                }
            }
        }
    }
}


struct SpecialEventsModel: Decodable {
    let data: [SpecialEventsDataModel]?
}

struct SpecialEventsDataModel: Decodable, Identifiable {
    let id = UUID()
    let eventID: Int?
    let eventName, eventDescription, eventVideoURL, eventThumbnailImageName: String?
    let eventThumbnailImageURL: String?
    let eventDateandTime, eventLocation, eventHost, eventType: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case eventName, eventDescription, eventVideoURL, eventThumbnailImageName, eventThumbnailImageURL, eventDateandTime, eventLocation, eventHost, eventType
    }
}
