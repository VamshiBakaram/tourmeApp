//
//  HomeContentItemView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 10/22/21.
//

import SwiftUI

struct HomeContentItemView: View {
    
    @State var homeContent: HomeContent
    
    @EnvironmentObject var menuData: MenuViewModel
    var currentIndex: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if currentIndex == 0 {
                    HStack(alignment: .center) {
                        Spacer()
                        Image("tourmeapp_logo")
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                }else{
                    BCGAsyncImage(url: URL(string: homeContent.thumbnailUrl)!)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(homeContent.title)
                    .font(.custom(.inriaSansBold, size: 22))
                    .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                    .frame(alignment: .leading)
                    .padding(.vertical)
                Text(homeContent.description)
                    .font(.custom(.inriaSansBold, size: 16))
                    .foregroundColor(.primary)
                    .padding(.bottom)
                
                
                if homeContent.showButton == true {
                    Button(action: {
                        if homeContent.keyword == "tours" {
                            menuData.selectedMenu = .tours
                        } else if homeContent.keyword == "live" {
                            menuData.selectedMenu = .live
                        } else if homeContent.keyword == "map" {
                            menuData.selectedMenu = .map
                        } else if homeContent.keyword == "settings" {
                            menuData.selectedMenu = .settings
                        } else {
                            print("Invalid keyword")
                        }
                    }) {
                        Text(homeContent.buttonText!)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.headline)
                            .kerning(1.2)
                    }
                    .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.vertical)
                }
                
                Spacer()
            }.padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

/*
struct HomeContentItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentItemView()
    }
}
*/
