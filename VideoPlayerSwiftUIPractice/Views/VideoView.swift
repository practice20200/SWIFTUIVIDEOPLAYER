//
//  VideoView.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-16.
//

import SwiftUI
import AVKit

struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                if let link = video.videoFiles.first?.link{
                    player = AVPlayer(url:  URL(string: link)!)
                    player.play()
                }
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(video:preView)
//        VideoView()
    }
}
