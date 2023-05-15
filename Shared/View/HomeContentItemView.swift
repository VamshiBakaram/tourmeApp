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
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                BCGAsyncImage(url: URL(string: homeContent.thumbnailUrl)!)
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
                Text(homeContent.title)
                    //.foregroundColor(Color("AccentColor3"))
                    .foregroundColor(Color("PrimaryColor"))
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.4)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(homeContent.description)
                    .kerning(1.2)
                    .padding(.horizontal)
                
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
                            .foregroundColor(.black)
                            .font(.headline)
                            .kerning(1.2)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .background(Color("AccentColor3"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, -25)
                }
                
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.top, 20)
    }
}

/*
struct HomeContentItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentItemView()
    }
}
*/
