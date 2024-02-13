//
//  NoInternetView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/8/21.
//

import SwiftUI

struct NoInternetView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @ObservedObject var tourViewModel: TourViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Spacer()
            
            Text("no_internet_unable_to_connect".localized(userLanguage))
                .font(.headline)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Button {
                //tourViewModel.loadTours(userLanguage: userLanguage)
            } label: {
                Text("no_internet_retry".localized(userLanguage))
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .background(Color("AccentColor3"))
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            Spacer()
        }

    }
}

struct NoInternetHomeContentView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @ObservedObject var homeContentViewModel: HomeContentViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            Spacer()
            
            Text("no_internet_unable_to_connect".localized(userLanguage))
                .font(.headline)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
            
            Button {
                homeContentViewModel.loadHomeContent(userLanguage: userLanguage)
            } label: {
                Text("no_internet_retry".localized(userLanguage))
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .background(Color("AccentColor3"))
                    .cornerRadius(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            Spacer()
        }

    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView(tourViewModel: TourViewModel())
    }
}
