//
//  CommentsViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 08/01/24.
//

import Foundation

class CommentsViewModel: ObservableObject {
    @Published var commentText: String = ""
    
    @Published var isShowLoading = false
    @Published var comments: CommentsModel?
    
    @Published var message: String?
    
    func getcomments(id: Int) {
        isShowLoading = true
        let url = "\(API.tourComments)\(id)"
        NetworkManager.shared.request(type: CommentsModel.self, url: url, httpMethod: .post) { [weak self]result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.comments = response
                    self.isShowLoading = false
                }
            case .failure(_):
                self.isShowLoading = false
                break
            }
        }
    }
    
    func postComment(comment: String, tourId: Int, id: Int, userId: String, date: String) {
        isShowLoading = true
        let url = API.postComment
        let parameters = PostComment(comments: comment, tourId: tourId, userId: userId, videoId: id, datetime: date)
        print(parameters)
        NetworkManager.shared.request(type: PostCommentResponseModel.self, url: url, httpMethod: .post, parameters: parameters, isTokenRequired: true) { [weak self]result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.comments = nil
                    self.message = "Comment posted successfully"
                    self.isShowLoading = false
                    self.getcomments(id: id)
                }
            case .failure(_):
                self.isShowLoading = false
                break
            }
        }
    }
    
    
}

struct CommentsModel: Decodable {
    let data: CommentsDataModel?
}

struct CommentsDataModel: Decodable {
    let videoID, videoLikecount: Int?
    let videoLike: Bool?
    let usersCommentdata: [UsersCommentdatum]?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case videoLikecount, videoLike, usersCommentdata
    }
}

struct UsersCommentdatum: Decodable {
    let commentID: Int?
    let userID, userName, comment, datetime: String?

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case userID = "userId"
        case userName, comment, datetime
    }
}


struct PostComment: Encodable {
    let comments: String
    let tourId: Int
    let userId: String
    let videoId: Int
    let datetime: String
    let isTrailer = true
}

struct PostCommentResponseModel: Decodable {
    let message: String?
}
