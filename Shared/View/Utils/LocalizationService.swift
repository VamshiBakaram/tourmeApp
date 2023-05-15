//
//  LocalizationService.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/14/22.
//


import Foundation

class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}
    
    var userLanguage: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "userLanguage") else {
                return .en
            }
            return Language(rawValue: languageString) ?? .en
        } set {
            if newValue != userLanguage {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "userLanguage")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
