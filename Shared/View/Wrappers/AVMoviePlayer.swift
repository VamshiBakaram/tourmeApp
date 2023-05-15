//
//  AVMoviePlayer.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 1/12/22.
//

import Foundation
import SwiftUI
import AVKit
import AVPlayerViewControllerSubtitles

struct AVMoviePlayer: UIViewControllerRepresentable {
        
    var player: AVQueuePlayer?
    var useSubtitles: Bool
    var subtitleURL: URL?
    //var subtitleURLs: [URL]?
    var currentUrl: URL?
    @SceneStorage("lastUrl") var lastUrl: URL? // = URL(string: "")
    
    class DummyClass { } ; let x = DummyClass()
    
    init(player: AVQueuePlayer?, useSubtitles: Bool, selectedSubtitle: String, currentUrl: URL?) {
        self.player = player
        self.useSubtitles = useSubtitles
        //self.subtitleURLs = subtitleURLs
        if selectedSubtitle != "Off" {
        self.subtitleURL = URL(string: selectedSubtitle)
        }
        self.currentUrl = currentUrl
    }
    
    /*
    init(player: AVQueuePlayer?, useSubtitles: Bool, subtitleURLs: [URL]?, currentUrl: URL?) {
        self.player = player
        self.useSubtitles = useSubtitles
        self.subtitleURLs = subtitleURLs
        self.currentUrl = currentUrl
    }
     */
    
    typealias UIViewControllerType = AVPlayerViewController
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let avViewController = AVPlayerViewController()
        avViewController.player = self.player
        avViewController.delegate = context.coordinator
        avViewController.showsPlaybackControls = true
        //avViewController.requiresLinearPlayback = true
        //avViewController.allowsPictureInPicturePlayback = true
        //avViewController.updatesNowPlayingInfoCenter = true
        
        avViewController.subtitleLabel?.textColor = .white
        return avViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
        if self.lastUrl != self.currentUrl {
               
            /*
            if self.subtitleURLs != nil {
                for subtitle in self.subtitleURLs! {
                    //let urlString = "https://tourmeapp.s3.amazonaws.com/vod/tel-aviv/subtitles/1/TelAviv1.en_US.srt"
                    uiViewController.addSubtitles().open(fileFromRemote: subtitle)
                    print("\(subtitle)")
                }
            }
             */
            
            if self.subtitleURL != nil {
                uiViewController.addSubtitles().open(fileFromRemote: self.subtitleURL!)
                print(self.subtitleURL!.absoluteString)
            }
            
            uiViewController.player = self.player
            
            //self.lastUrl = self.currentUrl
        }

    }
    
    func makeCoordinator() -> AVPlayerCoordinator {
        AVPlayerCoordinator(self)
    }
    
    class AVPlayerCoordinator: NSObject, AVPlayerViewControllerDelegate {
        
        var parent: AVMoviePlayer
        
        init(_ parent: AVMoviePlayer) {
            self.parent = parent
        }
        
    }
    
}
