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
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var tourDetailsViewModel = TourDetailsViewModel()
    @AppStorage("userLanguage") var userLanguage: Language = Language.en
    
    let tourIdValue: Int
    let titleFrom: String
    let descriptionFrom: String
    init(tourId: Int, titleFrom: String, descriptionFrom: String) {
        self.tourIdValue = tourId
        self.titleFrom = titleFrom
        self.descriptionFrom = descriptionFrom
        tourDetailsViewModel.getTourDetails(tourId: tourId)
    }
    @State var player: AVQueuePlayer?
    @State var currentUrl: URL?
    @State var commentsCount = 0
    @State var title: String = ""
    @State var titleDescription = ""
    @State var subtitleURL: URL?
    @State var selectedSubtitle: String = "off"
    @State var useSubtitles: Bool = true
    @State private var selectiedColor = 0
    
    var body: some View {
        ZStack {
            if tourDetailsViewModel.isShowIndicator {
                ShowProgressView()
            }else{
                if tourDetailsViewModel.tourDetails?.data?.videoDetails?.count ?? 0 == 0 {
                    OneView
                }else{
                    GeometryReader { proxy in
                        VStack {
                            TwoView
                            ZStack {
                                if tourDetailsViewModel.isPlayVideo {
                                    AVMoviePlayer(player: self.player, useSubtitles: self.useSubtitles, selectedSubtitle: self.selectedSubtitle, currentUrl: self.currentUrl)
                                        .frame(width: proxy.size.width, height: proxy.size.width / 1.78)
                                        .onAppear {
                                            // player?.play()
                                        }
                                }
                                if tourDetailsViewModel.isVideoLoading {
                                    ProgressView()
                                        .tint(tourDetailsViewModel.isPlayVideo ? Color.white : Color.black)
                                }
                            }
                            HStack {
                                Text(title)
                                    .font(.custom(.inriaSansBold, size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            HStack {
                                Text(titleDescription)
                                    .font(.custom(.inriaSansBold, size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.top, 0)
                            .padding(.horizontal)
                            ThreeView
                            /*

                             */
                            if tourDetailsViewModel.tourDetails?.data?.videoDetails?.count ?? 0 == 0 {
                                VStack(spacing: 15) {
                                    Image("movie_FILL0_wght300_GRAD0_opsz24 1")
                                    Text("No More Videos Available\nFor this Tour".localized(userLanguage))
                                        .font(
                                            .custom(.inriaSansBold, size: 14)
                                        )
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                }
                                .padding(.vertical, 50)
                            }else{
                                FourScrollView
                                /*

                                 */
                                                            }
                        }
                        .onAppear(perform: {
                            self.tourDetailsViewModel.getcomments(completion: {
                                self.player?.pause()
                                self.player = nil
                                self.currentUrl = URL(string: tourDetailsViewModel.trailerURL)
                                self.player = AVQueuePlayer(url: self.currentUrl ?? URL(fileURLWithPath: ""))
                                self.getcomments()
                                self.title = titleFrom
                                self.titleDescription = descriptionFrom
                                self.player?.play()
                            })
                        })
                        .background(colorScheme == .dark ? Color.black : Color(red: 0.98, green: 0.98, blue: 0.98))
                        .onDisappear {
                            self.player?.pause()
                        }
                    }
                    .sheet(isPresented: $tourDetailsViewModel.isShowShare) {
                        ShareSheet(activityItems: ["Turn your Holy Land dreams into reality… Easily. Safely. A Unforgettably and FREE!\n\nDownload the app from here - \niOS:- https://apps.apple.com/in/app/tourmeapp-israel/id1592914579\nAndroid:- https://play.google.com/store/apps/details?id=net.tourmeapp.tourmeapp&hl=en&gl=US"])
                    }
                    .sheet(isPresented: $tourDetailsViewModel.isShowCommentSheet) {
                        CommentsView(commentCount: $commentsCount, id: tourDetailsViewModel.selectedVideo?.videoID ?? 0, tourId: tourIdValue)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    }
                    
                }
            }
            
        }
    }
    
    var OneView: some View {
        VStack{
            HStack {
                Button(action: {
                    self.player?.pause()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(colorScheme == .light ? "back (3)" : "back (4)")
                })
                Text("Tour".localized(userLanguage))
                    .font(.custom(.inriaSansRegular, size: 20))
                    .fontWeight(.bold)
                Spacer()
                //                            .onSubmit {
                //                                print("selected")
                //                            }
                
            }
            .padding()
            VStack(spacing: 15) {
                Image("movie_FILL0_wght300_GRAD0_opsz24 1")
                Text("No More Videos Available\nFor this Tour".localized(userLanguage))
                    .font(
                        .custom(.inriaSansBold, size: 14)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
            }
            .padding(.vertical, 50)
            Spacer()
        }
    }
    
    var TwoView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(colorScheme == .light ? "back (3)" : "back (4)")
            })
            Text("Tour".localized(userLanguage))
                .font(.custom(.inriaSansRegular, size: 20))
                .fontWeight(.bold)
            Spacer()
            if sessionManager.isShowSubTitle {
                Picker(selection: $selectiedColor, label: Text("Subtitle:")) {
                    ForEach(0..<self.tourDetailsViewModel.colors.count, id: \.self) { index in
                        Text(self.tourDetailsViewModel.colors[index])
                            .tag(index)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectiedColor) { tag in
                    print(tag)
                    if tag != 0 {
                        self.selectedSubtitle = self.tourDetailsViewModel.selectedVideo?.srtFilesDetailsOnVideo?[tag - 1].srtFilePath ?? ""
                    }else{
                        self.selectedSubtitle = "off"
                    }
                }
            }
        }
        .padding()
        
    }
    
    var ThreeView: some View {
        HStack {
            HStack {
                VStack {
                    Image((tourDetailsViewModel.selectedVideo?.videoLikeCount ?? 0 == 1) ? (colorScheme == .light ? "like" : "thumb_up_FILL1_wght300_GRAD0_opsz24 1") : (colorScheme == .light ? "like 1" : "thumb_up"))
                        .resizable()
                        .frame(width: 24, height: 24)
                    HStack{
                        Text("\(tourDetailsViewModel.selectedVideo?.videoLikeCount ?? 0)   |")
                        Text("Like".localized(userLanguage))
                    }
                    .font(.custom(.inriaSansBold, size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .light ? Color(red: 0.28, green: 0.28, blue: 0.28) : Color.white)
                }
                .onTapGesture {
                    if tourDetailsViewModel.selectedVideo?.videoLikeCount ?? 0 == 1 {
                        tourDetailsViewModel.selectedVideo?.videoLikeCount = 0
                    }else{
                        tourDetailsViewModel.selectedVideo?.videoLikeCount = 1
                    }
                    tourDetailsViewModel.updateLike(like: tourDetailsViewModel.selectedVideo?.videoLikeCount ?? 0, tourId: tourIdValue, videoId: tourDetailsViewModel.selectedVideo?.videoID ?? 0, userId: sessionManager.userId ?? "")
                }
                Spacer()
                VStack {
                    Image(colorScheme == .light ? "comment" : "chat_FILL0_wght300_GRAD0_opsz24 1")
                        .resizable()
                        .frame(width: 24, height: 24)
                    HStack{
                        Text("\(commentsCount)   |")
                        Text("Comment".localized(userLanguage))
                    }
                    .font(.custom(.inriaSansBold, size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .light ? Color(red: 0.28, green: 0.28, blue: 0.28) : Color.white)
                }
                .onTapGesture {
                    tourDetailsViewModel.isShowCommentSheet = true
                }
                Spacer()
                VStack {
                    Image(colorScheme == .light ? "share 1" : "share_FILL0_wght300_GRAD0_opsz24 2")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Share".localized(userLanguage))
                        .font(.custom(.inriaSansBold, size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .light ? Color(red: 0.28, green: 0.28, blue: 0.28) : Color.white)
                }
                .onTapGesture {
                    tourDetailsViewModel.isShowShare = true
                }
                Spacer()
                NavigationLink {
                    SupportUsView()
                        .navigationBarHidden(true)
                } label: {
                    VStack {
                        Image(colorScheme == .light ? "support" : "favorite_FILL0_wght300_GRAD0_opsz24 1")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Support Us".localized(userLanguage))
                            .font(.custom(.inriaSansBold, size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .light ? Color(red: 0.28, green: 0.28, blue: 0.28) : Color.white)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
        .background(colorScheme == .light ? Color.white : Color(red: 0.28, green: 0.28, blue: 0.28))
        .padding(.top, 6)

    }
    
    var FourScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 12,content: {
                ForEach(0..<(tourDetailsViewModel.tourDetails?.data?.videoDetails?.count ?? 0), id: \.self) { index in
                    HStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 101, height: 70)
                                .background(
                                    LinearGradient(
                                        stops: [
                                            Gradient.Stop(color: Color(red: 0.02, green: 0.62, blue: 0.85), location: 0.00),
                                            Gradient.Stop(color: .black, location: 1.00),
                                        ],
                                        startPoint: UnitPoint(x: 0.5, y: 0),
                                        endPoint: UnitPoint(x: 0.5, y: 1)
                                    )
                                )
                                .cornerRadius(3)
                                .padding(.leading, 12)
                            Image("Group")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .shadow(radius: 6)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                if self.userLanguage == .en {
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].envideoTitle ?? "")
                                        .font(.custom(.inriaSansBold, size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                        .lineLimit(1)
                                }else if self.userLanguage == .es{
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].spvideoTitle ?? "")
                                        .font(.custom(.inriaSansBold, size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                        .lineLimit(1)
                                }else{
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].povideoTitle ?? "")
                                        .font(.custom(.inriaSansBold, size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            HStack {
                                if self.userLanguage == .en {
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].envideoDesc ?? "")
                                        .font(.custom(.inriaSansBold, size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                }else if self.userLanguage == .es{
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].spvideoDesc ?? "")
                                        .font(.custom(.inriaSansBold, size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                }else{
                                    Text(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].povideoDesc ?? "")
                                        .font(.custom(.inriaSansBold, size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            if self.userLanguage == .en {
                                Text("\(String(format: "%.2f", ((Double(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].envideoDuration ?? "") ?? 0.0)/60))) min  |  1 view  |  0 likes ")
                                    .font(.custom(.inriaSansBold, size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                            }else if self.userLanguage == .es{
                                Text("\(String(format: "%.2f", ((Double(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].spvideoDuration ?? "") ?? 0.0)/60))) min  |  1 view  |  0 likes ")
                                    .font(.custom(.inriaSansBold, size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                            }else{
                                Text("\(String(format: "%.2f", ((Double(tourDetailsViewModel.tourDetails?.data?.videoDetails?[index].povideoDuration ?? "") ?? 0.0)/60))) min  |  1 view  |  0 likes ")
                                    .font(.custom(.inriaSansBold, size: 12))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                            }
                            Spacer()
                        }
                        .padding(.all, 10)
                    }
                    .background(colorScheme == .light ? Color.white : Color(red: 0.28, green: 0.28, blue: 0.28))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        self.tourDetailsViewModel.colors.removeAll()
                        self.selectedSubtitle = ""
                        self.selectiedColor = 0
                        let video = tourDetailsViewModel.tourDetails?.data?.videoDetails?[index]
                        self.tourDetailsViewModel.selectedVideo = video
                        if video?.srtFilesDetailsOnVideo?.count ?? 0 != 0 {
                            self.tourDetailsViewModel.colors.append("Choose Subtitle".localized(userLanguage))
                            for srt in 0..<video!.srtFilesDetailsOnVideo!.count {
                                let separated = (video?.srtFilesDetailsOnVideo?[srt].srtFilePath ?? "").components(separatedBy: ".")
                                if ((separated[separated.count - 2]).suffix(2) == "BR") {
                                    self.tourDetailsViewModel.colors.append("Breton")
                                }else if ((separated[separated.count - 2]).suffix(2) == "US") {
                                    self.tourDetailsViewModel.colors.append("Us")
                                }else if ((separated[separated.count - 2]).suffix(2) == "ES") {
                                    self.tourDetailsViewModel.colors.append("Spanish")
                                }
                            }
                        }
                        self.player?.pause()
                        self.player = nil
                        if self.userLanguage == .en {
                            self.currentUrl = URL(string: tourDetailsViewModel.selectedVideo?.envideoURl ?? "")
                        }else if self.userLanguage == .es{
                            self.currentUrl = URL(string: tourDetailsViewModel.selectedVideo?.spvideoURl ?? "")
                        }else{
                            self.currentUrl = URL(string: tourDetailsViewModel.selectedVideo?.povideoURl ?? "")
                        }
                        self.player = AVQueuePlayer(url: self.currentUrl ?? URL(fileURLWithPath: ""))
                        self.player?.play()
                        self.getcomments()
                        if self.userLanguage == .en {
                            self.title = video?.envideoTitle ?? ""
                            self.titleDescription = video?.envideoDesc ?? ""
                        }else if self.userLanguage == .es{
                            self.title = video?.spvideoTitle ?? ""
                            self.titleDescription = video?.spvideoDesc ?? ""
                        }else{
                            self.title = video?.povideoTitle ?? ""
                            self.titleDescription = video?.povideoDesc ?? ""
                        }
                    }
                    
                }
            })
            .padding(.horizontal, 20)
        }
        .padding(.top, 8)

    }
    
    func colorChange(_ tag: Int) {
        print("Color tag: \(tag)")
    }
    
    func getcomments() {
        let url = "\(API.tourComments)\(tourDetailsViewModel.selectedVideo?.videoID ?? 0)"
        NetworkManager.shared.request(type: CommentsModel.self, url: url, httpMethod: .post) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.commentsCount = response.data?.usersCommentdata?.count ?? 0
                }
            case .failure(_):
                break
            }
        }
    }
}

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

struct VideoPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update the view controller if needed
    }
}

#Preview {
    TourPlayerView(tourId: 9, titleFrom: "", descriptionFrom: "")
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Nothing to update here
    }
}
