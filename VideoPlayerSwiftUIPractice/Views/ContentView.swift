//
//  ContentView.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                ForEach(Query.allCases, id: \.self){ searchQuery in
                    QueryTag(query: searchQuery, isSelected: false)
                }
            }
        }
        .background(Color("AccentColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
