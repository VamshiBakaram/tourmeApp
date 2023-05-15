//
//  MenuModel.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/3/21.
//

import SwiftUI

enum MenuItem: Int {
    case home = 0
    case map = 1
    case tours = 2
    case live = 3
    case settings = 4
    case newHome = 5
}

class MenuViewModel: ObservableObject {
    
    // Default
    @Published var selectedMenu: MenuItem = .newHome
        
    @Published var navigationText: String = "TourMeApp: Israel"
}
