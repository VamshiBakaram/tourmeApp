//
//  TourDetailsViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import Foundation

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

    var trailerURL = ""
        
    func getTourDetails(tourId: Int) {
        isShowIndicator = true
        NetworkManager.shared.request(type: TourDetailsModel.self, url: "\(API.tourDetails)\(tourId)") { result in
            switch result {
            case .success(let response):
                self.trailerURL = response.data?.trailerVideoPath ?? ""
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


struct TourDetailsModel: Decodable {
    let data: TourDetailsDataModel?
}

struct TourDetailsDataModel: Decodable {
    let tourID: Int?
    let enTourName, enTourDesc, spTourName, spTourDesc: String?
    let poTourName, poTourDesc: String?
    let videoDetails: [VideoDetail]?
    let trailerVideoPath: String?

    enum CodingKeys: String, CodingKey {
        case tourID = "tourId"
        case enTourName, enTourDesc, spTourName, spTourDesc, poTourName, poTourDesc, videoDetails
        case trailerVideoPath
    }
}

struct VideoDetail: Codable {
    let videoID: Int?
    let envideoName, envideoDesc, spvideoName, spvideoDesc, spvideoTitle, envideoURl, envideoTitle: String?
    let povideoName, povideoDesc: String?
    let videoURl: String?
    let thumbnailURLPath: String?
    let videoDuration: String?
    let isActive: Bool?
    let envideoDuration: String?
    let srtFilesDetailsOnVideo: [SrtFilePathModel]?
    var videoLikeCount, videoViewsCount: Int?
    
    

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case envideoName, envideoDesc, spvideoName, spvideoDesc,spvideoTitle, envideoURl, envideoTitle, povideoName, povideoDesc, videoURl
        case thumbnailURLPath = "thumbnailUrlPath"
        case videoDuration, isActive, videoLikeCount, videoViewsCount
        case envideoDuration
        case srtFilesDetailsOnVideo
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
