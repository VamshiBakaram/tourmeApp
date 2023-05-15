//
//  TourPlayerView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/6/21.
//

import SwiftUI
import AVKit
import FlagKit
import StoreKit

struct TourPlayerView: View {
    
    @State private var orientation = UIDeviceOrientation.unknown
    
    /*
    @AppStorage("requestReviewCounter") var requestReviewCounter: Int = 0
    @Environment(\.requestReview) var requestReview
    
    requestReviewCounter += 1
    let remainder = try requestReviewCounter % 3
    if remainder == 0 {
        requestReview()
    }
     */
    
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("useSubtitles") var useSubtitles: Bool = false
    
    @ObservedObject var s3ViewModel = S3ViewModel()
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    @EnvironmentObject var tourViewModel: TourViewModel
    
    @State var tour: Tour
    @State var isPlaying: Bool = false
    @State var currentUrl: URL?
    @State var selectedSubtitle: String = "Off"
    @State var lastUrl: URL?
    @State var busStops = [BusStop]()
    @State var isShowingNoPurchaseHistory = false
    
    @State var player: AVQueuePlayer?
    @State var subtitleURLs = [URL]()
    @State var items = [AVPlayerItem]()
            
    var body: some View {
                
        GeometryReader { proxy in
            
            VStack(spacing: 10) {
                HStack {
                    Button(action: {
                        tourViewModel.isShowingSelectedTour = false
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                    }
                    .padding()
                                        
                    if UIDevice.isIPad {
                        Text(tour.name)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .kerning(1.4)
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Subtitles:")
                            .kerning(1.2)
                        Picker("Selected subtitle \(selectedSubtitle)", selection: $selectedSubtitle) {
                            ForEach(-1..<self.subtitleURLs.count, id: \.self) { i in
                                if i == -1 {
                                    Text("Off").tag("Off")
                                } else {
                                    //Image(self.subtitleURLs[i].absoluteString.components(separatedBy: ".")[4].components(separatedBy: "_")[1], bundle: FlagKit.assetBundle).tag(self.subtitleURLs[i].absoluteString)
                                    
                                    Text(self.subtitleURLs[i].absoluteString.components(separatedBy: ".")[4].components(separatedBy: "_")[1]).tag(self.subtitleURLs[i].absoluteString)
                                }
                                
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                
                if UIDevice.isIPad { // && UIDevice.current.orientation.isLandscape {
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            
                            AVMoviePlayer(player: self.player, useSubtitles: self.useSubtitles, selectedSubtitle: self.selectedSubtitle, currentUrl: self.currentUrl)
                                .frame(width: proxy.size.width / 2, height: proxy.size.width / 2 / 1.78)
                            
                            Group {
                                Text(tour.description ?? "")
                                    .font(.body)
                                    .kerning(1.2)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        ScrollView(.vertical) {
                            
                            VStack(alignment: .leading) {
                                
                                ForEach(0..<self.busStops.count, id: \.self) { i in
                                    BusStopListItemView(tapAction: {
                                        
                                        s3ViewModel.loadSubtitles(tourName: self.tour.name, video: "\(i+1)") { results, error in
                                            print(results)
                                            //self.isPlaying = false
                                            self.player?.pause()
                                            self.player = nil
                                            self.currentUrl = URL(string: tour.videoUrl!)
                                            
                                            self.subtitleURLs = results.compactMap({ subtitle in
                                                URL(string: subtitle.subtitleUrl)
                                            })
                                            
                                            self.createPlayer(url: URL(string: self.busStops[i].videoUrl!), subtitleURLs: results.compactMap({ subtitle in
                                                URL(string: subtitle.subtitleUrl)
                                            }))
                                            self.player?.play()
                                        }
                                    }, stop: self.busStops[i], showCompact: proxy.size.width < 500)
                                        .alert(isPresented: $isShowingNoPurchaseHistory) {
                                            Alert(
                                                title: Text("Cannot find valid purchase history"),
                                                message: Text("Please make a purchase at tourmeapp.net or contact support for help. If you just purchased, please try again in a few minutes."),
                                                primaryButton: .destructive(Text("Purchase Now")) {
                                                    sessionManager.signOut()
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                    }
                    
                } else {
                    AVMoviePlayer(player: self.player, useSubtitles: self.useSubtitles, selectedSubtitle: self.selectedSubtitle, currentUrl: self.currentUrl)
                        .frame(width: proxy.size.width, height: proxy.size.width / 1.78)
                    
                    ScrollView(.vertical) {
                        
                        VStack(alignment: .leading) {
                            Group {
                                Text(tour.name)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .kerning(1.4)
                                    .foregroundColor(Color("PrimaryColor"))
                                
                                Text(tour.description ?? "")
                                    .font(.body)
                                    .kerning(1.2)
                            }
                            
                            ForEach(0..<self.busStops.count, id: \.self) { i in
                                BusStopListItemView(tapAction: {
                                    
                                    s3ViewModel.loadSubtitles(tourName: self.tour.name, video: "\(i+1)") { results, error in
                                        print(results)
                                        //self.isPlaying = false
                                        self.player?.pause()
                                        self.player = nil
                                        self.currentUrl = URL(string: tour.videoUrl!)
                                        
                                        self.subtitleURLs = results.compactMap({ subtitle in
                                            URL(string: subtitle.subtitleUrl)
                                        })
                                        
                                        self.createPlayer(url: URL(string: self.busStops[i].videoUrl!), subtitleURLs: results.compactMap({ subtitle in
                                            URL(string: subtitle.subtitleUrl)
                                        }))
                                        self.player?.play()
                                    }
                                }, stop: self.busStops[i], showCompact: proxy.size.width < 500)
                                    .alert(isPresented: $isShowingNoPurchaseHistory) {
                                        Alert(
                                            title: Text("Cannot find valid purchase history"),
                                            message: Text("Please make a purchase at tourmeapp.net or contact support for help. If you just purchased, please try again in a few minutes."),
                                            primaryButton: .destructive(Text("Purchase Now")) {
                                                sessionManager.signOut()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                            }
                        }
                    }
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .onAppear( perform: {
                
                s3ViewModel.loadSubtitles(tourName: self.tour.name, video: "0") { results, error in
                    self.busStops.removeAll()
                    self.busStops.append(contentsOf: tour.BusStops?.sorted(by: { cur, next in
                        cur.name < next.name
                    }) ?? [BusStop]())
                    
                    if currentUrl == nil {
                        self.currentUrl = URL(string: tour.videoUrl!)
                        self.createPlayer(url: URL(string: tour.videoUrl!), subtitleURLs: results.compactMap({ subtitle in
                            URL(string: subtitle.subtitleUrl)
                        }))
                    }

                }
            })
            .phoneOnlyStackNavigationView()
            .onRotate { newOrientation in
                        orientation = newOrientation
                    }
            
            
        }
    }
    
    func createPlayer(url: URL?, subtitleURLs: [URL]) {
        self.currentUrl = url
        self.subtitleURLs = subtitleURLs
        self.player = AVQueuePlayer(url: url!)
    }
    
    func createPlayerWithPlaylist(tour: Tour) {
        self.tour = tour
        
        items.removeAll()
        items.append(AVPlayerItem(url: URL(string: tour.videoUrl!)!))
        
        tour.BusStops?.forEach({ busStop in
            items.append(AVPlayerItem(url: URL(string: busStop.videoUrl!)!))
        })
        
        self.player = AVQueuePlayer(items: items)
    }
}

//struct TourPlayerView_Previews: PreviewProvider {
//    
//    @State static var useSubtitles = false
//    
//    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Parturient montes nascetur ridiculus mus mauris vitae ultricies leo integer. Egestas maecenas pharetra convallis posuere morbi leo urna molestie. Parturient montes nascetur ridiculus mus mauris. Et tortor consequat id porta nibh venenatis cras sed felis. Tincidunt nunc pulvinar sapien et."
//    
//    static let tour = Tour(language: Language.en,
//                           name: "Some Tour",
//                           description: lorem,
//                           enabled: true,
//                           position: GeoPoint(lat: 31.23444, lon: 34.54546),
//                           thumbnailUrl: "https://jbsonemanband.com/wp-content/uploads/2020/12/cropped-JBs-One-Man-Band-Logo-Hands-Free-1.png",
//                           videoUrl: "")
//    
//    static var previews: some View {
//        TourPlayerView(tour: tour)
//    }
//}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
