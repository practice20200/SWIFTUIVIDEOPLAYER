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
            urlRequest.setValue("563492ad6f91700001000001778168f230f9472d90fd50f6ad52adc1", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error") }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodeData = try decoder.decode(ResponseBody.self, from: data)
            
            self.videos = decodeData.videos
        }catch{
            print("Error: \(error.localizedDescription)")
        }
    }
}

//struct ResponseBody: Decodable {
//    var page: Int
//    var perPage: Int
//    var totalResults: Int
//    var url: String
//    var videos: [Video]
//}

//struct Video: Identifiable, Decodable{
//    var id: Int
//    var image: String
//    var duration: Int
//    var user: User
//    var videoFiles: [VideoFile]
//    
//    struct User: Identifiable, Decodable{
//        var id: Int
//        var name: String
//        var url: String
//    }
//    
//    struct VideoFile: Identifiable, Decodable{
//        var id: Int
//        var quolity: String
//        var fileType: String
//        var link: String
//    }
//}
//


