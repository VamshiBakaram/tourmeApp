//
//  SplashView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("tourmeapp_logo")
            .aspectRatio(contentMode: .fit)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
