//
//  LiveStreamView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 10/4/21.
//

import SwiftUI
import AVKit

struct LiveStreamView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @State var videoPlayer = VideoPlayer(player: AVPlayer(url: URL(string: "https://c37074706d9b.us-east-1.playback.live-video.net/api/video/v1/us-east-1.051453382230.channel.fjeLO4IajGNH.m3u8")!))

    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                
                Text("Live")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .kerning(1.4)
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                Button {
                    videoPlayer = VideoPlayer(player: AVPlayer(url: URL(string: "https://c37074706d9b.us-east-1.playback.live-video.net/api/video/v1/us-east-1.051453382230.channel.fjeLO4IajGNH.m3u8")!))
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
                .padding(.trailing)
            }
            
            videoPlayer
        }
        
    }
}

struct LiveStreamView_Previews: PreviewProvider {
    static var previews: some View {
        LiveStreamView()
    }
}
