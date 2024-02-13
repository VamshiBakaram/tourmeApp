//
//  AppDelegateViewModel.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 30/11/23.
//

import Amplify
import AmplifyPlugins
import Firebase
import FirebaseMessaging
import Purchases
import AVFAudio
import PayPalCheckout

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { _, _ in }
        //let config = CheckoutConfig.init(clientID: "AYRhpb1tU8a5lhNMquJbGbVjYB1--mXupCRLswEufAGS5FG5CcUwwrqIoWV_h98qOznVHCRo6ma8Z10X")
        let config = CheckoutConfig(
            clientID: "AYRhpb1tU8a5lhNMquJbGbVjYB1--mXupCRLswEufAGS5FG5CcUwwrqIoWV_h98qOznVHCRo6ma8Z10X",
            returnUrl: "net.tourmeapp.tourmeappisrael://paypalpay",
            environment: .sandbox
        )
        Checkout.set(config: config)
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
