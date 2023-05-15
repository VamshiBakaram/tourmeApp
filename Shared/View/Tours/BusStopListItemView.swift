//
//  TourStopListItemView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/6/21.
//

import SwiftUI

import SwiftUI

struct BusStopListItemView: View {
    
    var tapAction: (() -> Void)
    
    @State var stop: BusStop
    @State var showCompact = false
    
    var body: some View {
        
        VStack(alignment: .leading) {

            BCGAsyncImage(url: URL(string: stop.thumbnailUrl )!)
                .scaledToFit()
            
            Group {
                Text(stop.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .kerning(1.4)
                    .foregroundColor(Color("PrimaryColor"))
                
                Text(stop.description ?? "")
                    .font(.body)
                    .kerning(1.2)
            }
            //.padding(.horizontal)
        }
        //.frame(width: proxy.size.width)
        .onTapGesture {
            tapAction()
        }
    }
}

struct BusStopListItemView_Previews: PreviewProvider {
    
    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo integer. Egestas maecenas pharetra convallis posuere morbi leo urna molestie. Parturient montes nascetur ridiculus mus mauris. Et tortor consequat id porta nibh venenatis cras sed felis. Tincidunt nunc pulvinar sapien et."
    
    static var stop = BusStop(language: Language.en, name: "Some Sample Tour Stop", description: lorem, enabled: true, thumbnailUrl: "https://tourmeapp.net/wp-content/uploads/elementor/thumbs/tourmeapp_logo_redesign_02-p3l46b1nc03i4bowhb80urf0xehaycgnriz3gt0t1c.png")

    static var previews: some View {
        BusStopListItemView(tapAction: {}, stop: stop)
    }
}
