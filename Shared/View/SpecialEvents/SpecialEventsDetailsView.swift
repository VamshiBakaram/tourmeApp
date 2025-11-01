//
//  SpecialEventsDetailsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import SwiftUI
import Kingfisher
import YouTubePlayerKit

struct SpecialEventsDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State var isShowShare = false
    
    let specialEvent: SpecialEventsDataModel
    
    var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(colorScheme == .light ? "back (3)" : "back (4)")
                    })
                    Text("Back")
                        .font(.custom(.inriaSansRegular, size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack {
                        ZStack {
                            KFImage.url(URL(string: specialEvent.eventThumbnailImageURL ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: geometry.size.width)
                                .frame(height: 231)
                                .clipped()
                            VStack {
                                Spacer()
                                NavigationLink {
                                    YouTubePlayerView(YouTubePlayer(stringLiteral: "https://www.youtube.com/watch?v=\(specialEvent.eventVideoURL ?? "")"))
                                } label: {
                                    HStack {
                                        Text("Event is started •  ")
                                            .font(.custom(.inriaSansBold, size: 17))
                                            .foregroundStyle(Color.white)
                                            .padding(.bottom)
                                            .multilineTextAlignment(.center)
                                        Text("“Click here to watch the event.”")
                                            .font(.custom(.inriaSansBold, size: 17))
                                            .foregroundStyle(Color.white)
                                            .padding(.bottom)
                                            .underline(color: Color.white)
                                            .multilineTextAlignment(.center)
                                    }
                                }

                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text(specialEvent.eventName ?? "")
                                    .font(.custom(.inriaSansBold, size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                Spacer()
                                Image("share")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .onTapGesture {
                                        self.isShowShare = true
                                    }
                            }
                            
                            HStack(spacing: 10) {
                                Image("Special event icon-3")
                                Text(getConvertedDate(format: "dd MMM yy", date: specialEvent.eventDateandTime ?? ""))
                                    .font(.custom(.inriaSansBold, size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack(spacing: 10) {
                                Image("schedule_FILL0_wght300_GRAD0_opsz24 1")
                                Text(getConvertedDate(format: "hh:mm a", date: specialEvent.eventDateandTime ?? ""))
                                    .font(.custom(.inriaSansBold, size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack(spacing: 10) {
                                Image("location_on_FILL0_wght300_GRAD0_opsz24 1")
                                Text(specialEvent.eventLocation ?? "")
                                    .font(.custom(.inriaSansBold, size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            
                            HStack(spacing: 10) {
                                Image("person_FILL0_wght300_GRAD0_opsz24 (1) 1")
                                Text(specialEvent.eventHost ?? "")
                                    .font(.custom(.inriaSansBold, size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            if specialEvent.eventType ?? "" != "FREE" {
                                HStack(spacing: 10) {
                                    Image("confirmation_number_FILL0_wght300_GRAD0_opsz24 (1) 1")
                                    Text("Enrollment Fees : \(specialEvent.eventType ?? "")$")
                                        .font(.custom(.inriaSansBold, size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                }
                            }
                            
                            Divider()
                            
                            Text("About the Event")
                                .font(.custom(.inriaSansBold, size: 14))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                            
                            Text("24 Dec 23")
                                .font(.custom(.inriaSansBold, size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            NavigationLink {
                                Text("")
                            } label: {
                                Text("Enroll for this Event")
                                    .font(.custom(.inriaSansRegular, size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                                    .cornerRadius(5)
                                    .padding(.top)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal)

                    }
                }
            }
            .sheet(isPresented: $isShowShare) {
                ShareSheet(activityItems: ["Turn your Holy Land dreams into reality… Easily. Safely. A Unforgettably and FREE!\nDownload the app from here -\nhttps://apps.apple.com/in/app/tourmeapp-israel/id1592914579"])
            }
        })
    }
}

#Preview {
    SpecialEventsDetailsView( specialEvent: SpecialEventsDataModel(eventID: 12, eventName: "", eventDescription: "", eventVideoURL: "", eventThumbnailImageName: "", eventThumbnailImageURL: "", eventDateandTime: "", eventLocation: "", eventHost: "", eventType: ""))
}


struct YoutubePlayerView: View {
    var youTubePlayer: YouTubePlayer
    var body: some View {
        YouTubePlayerView(self.youTubePlayer) { state in
            // Overlay ViewBuilder closure to place an overlay View
            // for the current `YouTubePlayer.State`
            switch state {
            case .idle:
                ProgressView()
            case .ready:
                EmptyView()
            case .error(let error):
                Text(verbatim: "YouTube player couldn't be loaded")
            }
        }
    }
}
