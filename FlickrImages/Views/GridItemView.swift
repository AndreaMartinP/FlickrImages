//
//  GridItemView.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import SwiftUI

struct GridItemView: View {
    let size: Double
    let item: ImageDataModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: item.media.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}
