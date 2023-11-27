//
//  TourStopListItemView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/6/21.
//

import SwiftUI

import Kingfisher

struct BusStopListItemView: View {
    
    var tapAction: (() -> Void)
    
    @State var stop: BusStop
    @State var showCompact = false
    
    var body: some View {
        HStack {
            KFImage(URL(string: stop.thumbnailUrl)!)
                .resizable()
                .frame(width: 101, height: 70)
                .scaledToFit()
                .padding(.leading, 12)
            VStack(alignment: .leading) {
                Text(stop.name)
                  .font(
                    .custom(.inriaSansBold, size: 14)
                  )
                  .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85)) 
                  .lineLimit(1)
                Text(stop.description ?? "")
                  .font(
                    .custom(.inriaSansBold, size: 12)
                  )
                  .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                  .lineLimit(1)
                Spacer()
                Text("7:45 min")
                  .font(
                    .custom(.inriaSansBold, size: 12)
                  )
                  .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
            }
            .padding()
            .onTapGesture {
                tapAction()
            }
        }
        .foregroundColor(.clear)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
        .padding(.top, 8)
    }
}

struct BusStopListItemView_Previews: PreviewProvider {
    
    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo integer. Egestas maecenas pharetra convallis posuere morbi leo urna molestie. Parturient montes nascetur ridiculus mus mauris. Et tortor consequat id porta nibh venenatis cras sed felis. Tincidunt nunc pulvinar sapien et."
    
    static var stop = BusStop(language: Language.en, name: "Some Sample Tour Stop", description: lorem, enabled: true, thumbnailUrl: "https://tourmeapp.net/wp-content/uploads/elementor/thumbs/tourmeapp_logo_redesign_02-p3l46b1nc03i4bowhb80urf0xehaycgnriz3gt0t1c.png")

    static var previews: some View {
        BusStopListItemView(tapAction: {}, stop: stop)
    }
}
