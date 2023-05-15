//
//  UIDevice+Extensions.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/16/22.
//

import SwiftUI

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
