//
//  ResponseBody.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-18.
//

import Foundation
struct ResponseBody: Decodable {
    var page: Int
    var perPage: Int
    var totalResults: Int
    var url: String
    var videos: [Video]
}
