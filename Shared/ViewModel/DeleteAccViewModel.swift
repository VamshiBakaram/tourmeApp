//
//  DeleteAccViewModel.swift
//  tourmeapp
//
//  Created by Ahex-Guest on 10/10/24.
//
import SwiftUI

class DeleteAccViewModel: ObservableObject {
   
    
    @Published var errorMessage: String?
    
    @Published var isShowLoader = false
    @AppStorage("email") var email = ""
    
    
    func deleteAcc(completion: @escaping(DeleteAccModel) -> Void) {
        isShowLoader = true
        let url = "\(API.deleteAcc)?email=\(email)"
        NetworkManager.shared.request(type: DeleteAccModel.self, url: url, httpMethod: .post, isTokenRequired: true) { [weak self]result in
            guard let self = self else { return }
            isShowLoader = false
            switch result {
            case .success(let response):
                errorMessage = response.message ?? ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    completion(response)
                })
            case .failure(let error):
                switch error {
                case .message(message: let message):
                    errorMessage = message
                case .error(error: let error):
                    errorMessage = error
                }
            }
            
        }
        
    }
    


}
