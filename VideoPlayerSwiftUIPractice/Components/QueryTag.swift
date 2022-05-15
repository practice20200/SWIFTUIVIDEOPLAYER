//
//  QueryTag.swift
//  VideoPlayerSwiftUIPractice
//
//  Created by Apple New on 2022-05-15.
//

import SwiftUI

struct QueryTag: View {
    var query: Query
    var isSelected: Bool
    
    var body: some View {
        Text(query.rawValue)
            .bold()
            .foregroundColor(isSelected ? .black: .gray)
        
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
    }
}

struct QueryTag_Previews: PreviewProvider {
    static var previews: some View {
        QueryTag(query: Query.food, isSelected: true)
    }
}
