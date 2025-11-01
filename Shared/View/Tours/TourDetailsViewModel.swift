//
//  TourDetailsViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import Foundation
import SwiftUI

class TourDetailsViewModel: ObservableObject {
    
    @Published var isShowIndicator = false
    @Published var tourDetails: TourDetailsModel?
    @Published var isPlayVideo = false
    @Published var isVideoLoading = true
    @Published var errorMessage = ""
    @Published var commentsCount = 0
    @Published var isShowCommentSheet = false
    
    @Published var selectedVideo: VideoDetail?
    @Published var isShowShare = false
    @Published var colors: [String] = []
    @AppStorage("userLanguage") var userLanguage: Language = Language.en
    
    var trailerURL = ""
        
    func getTourDetails(tourId: Int) {
        isShowIndicator = true
        NetworkManager.shared.request(type: TourDetailsModel.self, url: "\(API.tourDetails)\(tourId)") { result in
            switch result {
            case .success(let response):
                if self.userLanguage == .en {
                    self.trailerURL = response.data?.trailerVideoPath ?? ""
                }else if self.userLanguage == .es{
                    self.trailerURL = response.data?.spTrailerVideoPath ?? ""
                }else{
                    self.trailerURL = response.data?.poTrailerVideoPath ?? ""
                }
                self.selectedVideo = response.data?.videoDetails?.first
                self.tourDetails = response
                self.isPlayVideo = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.isVideoLoading = false
                    self.getcomments(completion: {
                        
                    })
                })
            case .failure(let error):
                switch error {
                case .message(message: let message):
                    self.errorMessage = message
                case .error(error: let error):
                    self.errorMessage = error
                }
            }
            self.isShowIndicator = false
        }
    }
    
    func updateLike(like: Int, tourId: Int, videoId: Int, userId: String) {
        let parameters = UpdateLike(tourId: tourId, userId: userId, videoId: videoId, videoLike: like)
        NetworkManager.shared.request(type: PostCommentResponseModel.self, url: API.updateLike, httpMethod: .post, parameters: parameters) { [weak self]result in
            guard let _ = self else { return }
        }
    }
    
    func getcomments(completion: @escaping() -> Void) {
        let url = "\(API.tourComments)\(selectedVideo?.videoID ?? 0)"
        NetworkManager.shared.request(type: CommentsModel.self, url: url, httpMethod: .post) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion()
                    self.commentsCount = response.data?.usersCommentdata?.count ?? 0
                }
            case .failure(_):
                break
            }
        }
    }
}

struct UpdateLike: Encodable {
    let tourId: Int
    let userId: String
    let videoId: Int
    let videoLike: Int
}

struct SrtFilePathModel: Codable  {
    let srtFilePath: String?
}


struct TourDetailsModel: Decodable {
    let data: TourDetailsDataModel?
}

struct TourDetailsDataModel: Decodable {
    let tourID: Int?
    let enTourName, enTourDesc, spTourName, spTourDesc: String?
    let poTourName, poTourDesc, trailerVideo: String?
    let trailerVideoPath: String?
    let spTrailerVideo: String?
    let spTrailerVideoPath: String?
    let poTrailerVideo: String?
    let poTrailerVideoPath: String?
    let videoDetails: [VideoDetail]?

    enum CodingKeys: String, CodingKey {
        case tourID = "tourId"
        case enTourName, enTourDesc, spTourName, spTourDesc, poTourName, poTourDesc, trailerVideo, trailerVideoPath, spTrailerVideo, spTrailerVideoPath, poTrailerVideo, poTrailerVideoPath, videoDetails
    }
}

struct VideoDetail: Decodable {
    let videoID: Int?
    let envideoName: String?
    let envideoURl: String?
    let spvideoName: String?
    let spvideoURl: String?
    let povideoName: String?
    let povideoURl: String?
    let envideoTitle, envideoDesc, spvideoTitle, spvideoDesc: String?
    let povideoTitle, povideoDesc: String?
    let thumbnailURLPath: String?
    let envideoDuration, spvideoDuration, povideoDuration: String?
    let isActive: Bool?
    var videoLikeCount, videoViewsCount: Int?
    let srtFilesDetailsOnVideo: [SrtFilesDetailsOnVideo]?
    //let videoSrtDetailsOnVideo: JSONNull?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case envideoName, envideoURl, spvideoName, spvideoURl, povideoName, povideoURl, envideoTitle, envideoDesc, spvideoTitle, spvideoDesc, povideoTitle, povideoDesc
        case thumbnailURLPath = "thumbnailUrlPath"
        case envideoDuration, spvideoDuration, povideoDuration, isActive, videoLikeCount, videoViewsCount, srtFilesDetailsOnVideo
    }
}

struct SrtFilesDetailsOnVideo: Decodable {
    let srtID, videoID: Int?
    let srtFileName: String?
    let srtFilePath: String?

    enum CodingKeys: String, CodingKey {
        case srtID = "srtId"
        case videoID = "videoId"
        case srtFileName, srtFilePath
    }
}
