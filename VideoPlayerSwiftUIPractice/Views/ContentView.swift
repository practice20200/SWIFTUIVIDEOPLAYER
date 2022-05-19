//
//  ContentView.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoManager = VideoManager()
    var colums = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    ForEach(Query.allCases, id: \.self){ searchQuery in
                        QueryTag(query: searchQuery, isSelected: videoManager.selectedQuery == searchQuery)
                            .onTapGesture {
                                videoManager.selectedQuery = searchQuery
                            }
                    }
                }
                ScrollView{
                    if videoManager.videos.isEmpty{
                        ProgressView()
                    }else{
                        LazyVGrid(columns: colums, spacing: 20) {
                            ForEach(videoManager.videos, id: \.id){
                                video in
                                NavigationLink {
                                    VideoView(video: video)
                                }label: {
                                    VideoCard(video: video)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color("AccentColor"))
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
