//
//  TourModel.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 6/4/21.
//

import Combine
import Amplify
import AWSPluginsCore

class HomeContentViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var homeContent: [HomeContent] = [HomeContent]()
    @Published var error: Error?
    
    func loadHomeContent(userLanguage: Language) {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://d3aa37cj97ghel.cloudfront.net/home_content_\(userLanguage.rawValue).json") else {
                    return
                }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let homeContentData = try JSONDecoder().decode([HomeContent].self, from: data)
                        DispatchQueue.main.async {
                            self.homeContent = homeContentData
                            
                            self.homeContent.sort { cur, next in
                                next.sortOrder > cur.sortOrder
                            }
                            
                            self.isLoading = false
                        }
                    } catch let error {
                        print("Error: \(error)")
                        DispatchQueue.main.async {
                            self.error = error
                            self.isLoading = false
                        }
                    }
                }.resume()
    }
    
    /*
    func loadHomeContent(userLanguage: Language) {
        
        self.isLoading = true
        
        let homeContent = HomeContent.keys
        let predicate = homeContent.language == userLanguage.rawValue.uppercased() && homeContent.enabled == true
        Amplify.API.query(request: .list(HomeContent.self, where: predicate)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let homeContent):
                    print("Successfully retrieved list of homeContent: \(homeContent)")
                    DispatchQueue.main.async {
                        self.homeContent = homeContent
                        self.homeContent.sort { cur, next in
                            next.sortOrder > cur.sortOrder
                        }
                        self.error = nil
                        self.isLoading = false
                    }
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                    DispatchQueue.main.async {
                        self.error = error
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                print("Got failed event with error \(error)")
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
    */
    
}
