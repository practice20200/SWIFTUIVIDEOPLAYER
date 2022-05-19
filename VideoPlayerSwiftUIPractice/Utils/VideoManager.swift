//
//  VideoManager.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-15.
//

import Foundation
import UIKit
import SwiftUI

enum Query: String, CaseIterable {
    case nature, animals, people, ocean, food
}


class VideoManager: ObservableObject{

    @Published private(set) var videos: [Video] = []
    @Published var selectedQuery: Query = Query.nature{
        didSet{
            Task.init{
                await findVideos(topic: selectedQuery)
            }
        }
    }
    
    init(){
        Task.init{
           await findVideos(topic: selectedQuery)
        }
    }
    
    func findVideos(topic: Query) async {
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientaion=portrait") else {fatalError("URL NOT FOUNDED")}
            

            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("Enter Your API", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodeData = try decoder.decode(ResponseBody.self, from: data)

            DispatchQueue.main.async { [weak self] in
                self?.videos = []
                self?.videos = decodeData.videos
            }
            
        }catch{
            print("Error: \(error.localizedDescription)")
        }
    }
}



