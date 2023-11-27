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

struct ToursGridView: View {
        
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @EnvironmentObject var menuData: MenuViewModel
    @EnvironmentObject var tourViewModel: TourViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                VStack(alignment: .leading) {
                    Text("Tours")
                        .font(.custom(.inriaSansBold, size: 20))
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 18, content: {
                            ForEach(tourViewModel.tours, id: \.id) { tour in
                                NavigationLink {
                                    TourPlayerView(tour: tour)
                                        .navigationBarHidden(true)
                                } label: {
                                    ZStack(alignment: .leading) {
                                        KFImage.url(URL(string: tour.thumbnailUrl))
                                            .resizable()
                                            .frame(width: (reader.size.width / 2) - 20,height: 215)
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
                                        VStack(alignment: .leading) {
                                            Text(tour.name)
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
                        .refreshable {
                            tourViewModel.loadTours(userLanguage: userLanguage)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .onAppear {
                    if tourViewModel.tours.count == 0 && !tourViewModel.isLoading {
                        tourViewModel.loadTours(userLanguage: userLanguage)
                    }
                }
                //.edgesIgnoringSafeArea(.all)
            }
        }
        
    }
}

struct ToursGridView_Previews: PreviewProvider {
    static var previews: some View {
        ToursGridView()
    }
}
