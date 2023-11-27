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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { _, _ in }

        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        Messaging.messaging().subscribe(toTopic: "announcements") { error in
          print("Subscribed to announcements topic")
        }
        
        let session = AVAudioSession.sharedInstance()
        do {
          try session.setCategory(.playback, mode: .moviePlayback)
          try session.setActive(true)
        } catch {
          print("Error: \(error.localizedDescription)")
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            defer { completionHandler() }
            print("User tapped push notification")
            //NewsItem.makeNewsItem(aps)
        }
    
    private func process(_ notification: UNNotification) {

        let userInfo = notification.request.content.userInfo

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        /*
         if let newsTitle = userInfo["newsTitle"] as? String,
         let newsBody = userInfo["newsBody"] as? String {
         let newsItem = NewsItem(title: newsTitle, body: newsBody, date: Date())
         NewsModel.shared.add([newsItem])
         }
         */
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        //Analytics.logEvent("NEWS_ITEM_PROCESSED", parameters: nil)
        //Analytics.logEvent("NOTIFICATION_PROCESSED", parameters: nil)
    }
    
}

extension AppDelegate: MessagingDelegate {
    func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        let tokenDict = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict)
    }
}



@main
struct tourmeappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var userPreferencesStore = UserPreferencesStore()
    
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
                        .environmentObject(userPreferencesStore)
                }else{
                    MainView()
//                    switch sessionManager.authState {
//                    case .login:
//                        LoginView()
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
                }
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
    
//    private func configureAmplify() {
//        do {
//            let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
//            try Amplify.add(plugin: dataStorePlugin)
//            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())
//            try Amplify.configure()
//        } catch {
//            print("An error occurred setting up Amplify: \(error)")
//        }
//    }
}
