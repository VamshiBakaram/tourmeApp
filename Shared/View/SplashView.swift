//
//  SplashView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                
                //Image("tourmeapplogo")
                Image("en_gedi_israel")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    /*
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                     */
                
                Image("tourmeapplogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    .padding(.top, 200)
                    .shadow(color: .white, radius: 30)
                    .shadow(color: .white, radius: 30)
                    .shadow(color: .white, radius: 30)
            }
            
        }
        
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SplashView().colorScheme($0)
        }
    }
}
