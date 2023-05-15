//
//  MapPinImage.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/27/21.
//

import SwiftUI

struct MapPinImage: View {
    var body: some View {
        Image("tourmeapp_map_pin")
            .resizable()
            .scaledToFit()
            .foregroundColor(.yellow)
            .frame(width: 32, height: 32)
    }
}

struct MapPinImage_Previews: PreviewProvider {
    static var previews: some View {
        MapPinImage()
    }
}
