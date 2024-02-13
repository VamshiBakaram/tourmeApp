//
//  tourmeappApp.swift
//  Shared
//
//  Created by Jonathan Burris on 6/3/21.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import Firebase
import FirebaseMessaging
import Purchases
import AVFAudio

@main
struct tourmeappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var userPreferencesStore = UserPreferencesStore()
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @State private var isShowFlashView = false
    
    init() {
        /// Force showOnboarding for testing
        // currentPage = 1
        //showOnboarding = true
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        //Purchases.configure(withAPIKey: "AkSrEcjEeIUKMvojMYwjjKygJCXLGeZe")
        
        //configureAmplify()
        
        //sessionManager.getCurrentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            if isShowFlashView {
                if showOnboarding {
                    OnboardingView()
                        .environmentObject(sessionManager)
                }else{
                    if sessionManager.authManager == "login" {
                        LoginView()
                            .environmentObject(sessionManager)
                    }else{
                        MainView()
                            .environmentObject(sessionManager)
                    }
                }
//                    switch sessionManager.authState {
//                    case .login:
//                        LoginView(
//                            .environmentObject(sessionManager)
//                    case .signUp:
//                        SignUpView()
//                            .environmentObject(sessionManager)
//                    case .confirmCode(let username):
//                        ConfirmCodeView(username: username)
//                            .environmentObject(sessionManager)
//                    case .disabled:
//                        MainView()
//                            .environmentObject(sessionManager)
//                    case .resetPassword:
//                        ResetPassword()
//                            .environmentObject(sessionManager)
//                    case .confirmResetPassword(username: let username):
//                        ConfirmResetPassword(username: username)
//                            .environmentObject(sessionManager)
//                    }
            }else{
                SplashView()
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            withAnimation {
                                self.isShowFlashView = true
                            }
                        })
                    })
            }
        }
    }
}
