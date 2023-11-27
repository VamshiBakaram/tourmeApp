//
//  PlayerViewModel.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/9/21.
//

import SwiftUI
import AVKit

class PlayerViewModel: ObservableObject {
    
    @Published var currentUrl: URL?
    @Published var lastUrl: URL?
    //@Published var player: AVPlayer?
    @Published var player: AVQueuePlayer?
    @Published var subtitleURLs: [URL]?
    @Published var useSubtitles = false
    @Published var items = [AVPlayerItem]()
    @Published var tour: Tour?
    
    func killPlayer() {
        self.player = nil
    }
        
    func createPlayer(url: URL?, subtitleURLs: [URL]?) {
        self.currentUrl = url
        self.subtitleURLs = subtitleURLs
        //self.player = AVPlayer(url: url!)
        self.player = AVQueuePlayer(url: url!)
    }
    
    func createPlayerWithPlaylist(tour: Tour) {
        //self.player = AVPlayer()
        
        self.tour = tour
        
        items.removeAll()
        items.append(AVPlayerItem(url: URL(string: tour.videoUrl!)!))
        
        tour.BusStops?.items?.forEach({ busStop in
            items.append(AVPlayerItem(url: URL(string: busStop.videoUrl!)!))
        })
        
        self.player = AVQueuePlayer(items: items)
    }
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
}
