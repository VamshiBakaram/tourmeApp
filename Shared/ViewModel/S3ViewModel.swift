//
//  S3ViewModel.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/13/22.
//

import Foundation
import AWSS3

class S3ViewModel: ObservableObject {
    
    fileprivate let baseUrl = "https://tourmeapp.s3.amazonaws.com/"
    fileprivate let accessKey = "AKIAQX6W4JZLA5TWERFC"
    fileprivate let secretKey = "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"
    fileprivate let bucketName = "tourmeapp"
    
    @Published var isLoading = false
    //@Published var subtitles: [Subtitle] = [Subtitle]()
    @Published var error: Error?
    
    func loadSubtitles(tourName: String, video: String, completion: (@escaping (_ result: [Subtitle], _ error: Error?) -> Void)) {
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let request = AWSS3ListObjectsV2Request()!
        request.bucket = bucketName
        request.prefix = "vod/\(tourName.lowercased())/subtitles/\(video)"
        print(request.prefix)
        
        let s3 = AWSS3.default()
        
        s3.listObjectsV2(request).continueWith { task in
            var subtitles: [Subtitle] = [Subtitle]()

            if let error = task.error {
                print("Error: \(error)")
                completion(subtitles, error)
                return [Subtitle]()
            }
                        
            DispatchQueue.main.async {
                subtitles.removeAll()
            }
            if task.result?.contents != nil {
                for object in (task.result?.contents)! {
                    if object.key!.hasSuffix(".srt") {
                        let subtitleUrl = "\(self.baseUrl)\(object.key!)"
                        print(subtitleUrl)
                        subtitles.append(Subtitle(language: Language.en, subtitleUrl: subtitleUrl, mimeType: "application/x-subrip"))
                    }
                }
            }
            
            DispatchQueue.main.async {
                completion(subtitles, nil)
            }
            return nil
        }
        
        
    }
    
}
