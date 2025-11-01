//
//  ToursGridView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/16/22.
//

import SwiftUI
import Amplify
import AWSPluginsCore
import Kingfisher
import ToastSwiftUI

struct ToursGridView: View {
        
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @StateObject var tourViewModel = TourViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    
    var isFromHome = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if tourViewModel.isShowIndicator {
                    ShowProgressView()
                }else{
                    GeometryReader { reader in
                        VStack(alignment: .leading) {
                            if isFromHome {
                                HStack {
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(colorScheme == .light ? "back (3)" : "back (4)")
                                    })
                                    Text("Tours".localized(userLanguage))
                                        .font(.custom(.inriaSansRegular, size: 22))
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding()
                            }else{
                                Text("Tours".localized(userLanguage))
                                    .font(.custom(.inriaSansBold, size: 20))
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                            }
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 18, content: {
                                    ForEach(tourViewModel.toursList) { tour in
                                        NavigationLink {
                                            NavigationLazyView(TourPlayerView(tourId: tour.tourID ?? 0, titleFrom: tour.tourName ?? "", descriptionFrom: tour.tourDescription ?? ""))
                                                .navigationBarHidden(true)
                                        } label: {
                                            ZStack(alignment: .leading) {
                                                KFImage.url(URL(string: tour.imageURLPath ?? ""))
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: (reader.size.width / 2) - 30,height: 190,alignment: .center)
//                                                    .aspectRatio(10, contentMode: .fit)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
                                                VStack(alignment: .leading) {
                                                    Text(tour.tourName ?? "")
                                                        .font(.custom(.inriaSansRegular, size: 20))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                        .padding()
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                })
                                .padding(.horizontal, 20)
                                .padding(.bottom)
                                .refreshable {
                                    tourViewModel.getTours()
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }.toast($tourViewModel.errorMessage)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ToursGridView_Previews: PreviewProvider {
    static var previews: some View {
        ToursGridView()
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
