//
//  MenuView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI
import Amplify

struct MenuView: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    let user: AuthUser
    
    // Animation ...
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .center, spacing: 10, content: {
                Image("jb1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Text("\(sessionManager.userProfile.givenName) \(sessionManager.userProfile.familyName)")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("Hi!")
                    .font(.title2)
            })
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .padding(.top, 5)
            
            // Menu buttons...
            
            VStack(spacing: 18) {
                
                MenuButton(name: .home, image: "house", selectedMenu: $menuData.selectedMenu, animation: animation)
                                
                MenuButton(name: .tours, image: "mappin.and.ellipse", selectedMenu: $menuData.selectedMenu, animation: animation)
                
                MenuButton(name: .settings, image: "gear", selectedMenu: $menuData.selectedMenu, animation: animation)
                
                MenuButton(name: .support, image: "person.crop.circle.badge.questionmark", selectedMenu: $menuData.selectedMenu, animation: animation)
                                
                Button("Sign Out", action: {
                    sessionManager.signOut()
                })
                
            }
            .padding(.leading)
            .frame(width: UIScreen.main.bounds.width, alignment: .center)
            .padding(.top, 30)
            
            Divider()
                .background(Color.white)
                .padding(.top, 30)
                .padding(.horizontal, 25)
                        
            MenuButton(name: .account, image: "person.crop.circle", selectedMenu: $menuData.selectedMenu, animation: animation)
                .padding(.leading)
            
        }
        .padding(.vertical)
        // Default size
        .frame(width: UIScreen.main.bounds.width)
        .onAppear(perform: {
        })
    }
}
