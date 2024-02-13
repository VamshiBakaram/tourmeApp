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
//struct AVMoviePlayer: UIViewControllerRepresentable {
//        
//    var player: AVQueuePlayer?
//    var currentUrl: URL?
//    var subTitleURL: URL?
//        
//    init(player: AVQueuePlayer?, currentUrl: URL?, ) {
//        self.player = player
//        self.currentUrl = currentUrl
//    }
//    
//    typealias UIViewControllerType = AVPlayerViewController
//    
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let avViewController = AVPlayerViewController()
//        avViewController.player = self.player
//        avViewController.delegate = context.coordinator
//        avViewController.showsPlaybackControls = true
//        return avViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        if subTitleURL != nil {
//            uiViewController.addSubtitles()
//            uiViewController.open(fileFromRemote: subTitleURL!)
//        }
//        uiViewController.player = self.player
//
//    }
//    
//    func makeCoordinator() -> AVPlayerCoordinator {
//        AVPlayerCoordinator(self)
//    }
//    
//    class AVPlayerCoordinator: NSObject, AVPlayerViewControllerDelegate {
//        var parent: AVMoviePlayer
//        init(_ parent: AVMoviePlayer) {
//            self.parent = parent
//        }
//    }
//    
//}


struct AVMoviePlayer: UIViewControllerRepresentable {
        
    var player: AVQueuePlayer?
    var useSubtitles: Bool
    var subtitleURL: URL?
    var currentUrl: URL?
    
    init(player: AVQueuePlayer?, useSubtitles: Bool, selectedSubtitle: String, currentUrl: URL?) {
        self.player = player
        self.useSubtitles = useSubtitles
        if selectedSubtitle != "off" {
            self.subtitleURL = URL(string: selectedSubtitle)
        }else{
            self.subtitleURL = nil
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
        if self.subtitleURL != nil {
            uiViewController.open(fileFromRemote: self.subtitleURL!)
            uiViewController.addSubtitles()
            print(self.subtitleURL!.absoluteString)
        }else{
            uiViewController.open(fileFromRemote: URL(fileURLWithPath: "hghgh"))
        }
        uiViewController.player = self.player
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
