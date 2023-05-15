//
//  CustomVideoPlayer.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/6/21.
//

import SwiftUI
import AVKit
import AVPlayerViewControllerSubtitles

struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    @ObservedObject var playerViewModel: PlayerViewModel

    @Binding var isPlaying: Bool
    @Binding var useSubtitles: Bool
                
    fileprivate func updateController(_ controller: AVPlayerViewController) {
                
        controller.allowsPictureInPicturePlayback = true
        controller.updatesNowPlayingInfoCenter = true
        
        if playerViewModel.subtitleURLs != nil {
            for subtitle in playerViewModel.subtitleURLs! {
                controller.addSubtitles().open(fileFromRemote: subtitle)
                controller.addSubtitles().open(fileFromRemote: subtitle, encoding: String.Encoding.utf8)
            }
        }
        
        controller.player = playerViewModel.player
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        controller.delegate = context.coordinator
        updateController(controller)
        
        
        return controller
    }
    
    class DummyClass { } ; let x = DummyClass()
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

        if playerViewModel.lastUrl != playerViewModel.currentUrl {
            playerViewModel.lastUrl = playerViewModel.currentUrl
            updateController(uiViewController)
        }
                
        if self.isPlaying {
            uiViewController.player?.play()
        } else {
            uiViewController.player?.pause()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        var parent: CustomVideoPlayer
        
        init(_ parent: CustomVideoPlayer) {
            self.parent = parent
        }
    }
}
