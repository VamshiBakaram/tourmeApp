//
//  API.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 26/12/23.
//

import Foundation

struct API {
    private init() {}
    private static let baseURL = "http://tourmeadmin-001-site1.anytempurl.com/api/"
    
    static let login = baseURL + "Account/user-login"
    static let signup = baseURL + "Account/user-register"
    static let forgotPassword = baseURL + "Account/forgetpassword?email="
    static let resetPassword = baseURL + "Account/reset-Password"
    
    static let specialEvents = baseURL + "SpecialEvents/getall-eventdetails-user"
    static let tours = baseURL + "Tours/getall-tourdetails-user"
    static let tourDetails = baseURL + "Video/getall-videosdetails-user?tourId="
    static let tourComments = baseURL + "LikeComments/get-videolike-comments?videoId="
    static let postComment = baseURL + "LikeComments/create-videoComments"
    static let updateLike = baseURL + "LikeComments/create-videolike"
    
    static let savePayment = baseURL + "Payment/get-transaction-details/orderId?orderId="
    
    static let updateProfile = baseURL + "User/Upadte-userprofile"
}
