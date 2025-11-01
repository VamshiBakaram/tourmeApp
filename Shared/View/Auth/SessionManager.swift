//
//  SessionManager.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 7/19/21.
//
import Combine
import SwiftUI

final class SessionManager: ObservableObject {
    
    @AppStorage("token") var token: String?
    @AppStorage("userId") var userId: String?
    @AppStorage("isShowHome") var isShowHome = false
    @AppStorage("authManager") var authManager = "signUp"
    
    @AppStorage("email") var email = ""
    @AppStorage("displayName") var displayName = ""
    @AppStorage("phone") var phone = ""
    @AppStorage("familyName") var familyName = ""
    @AppStorage("isShowSubTitle") var isShowSubTitle = true
    
    @AppStorage("isShowSignUp") var isShowSignUp = false
    
    
}
