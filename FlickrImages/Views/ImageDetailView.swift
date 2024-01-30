//
//  ImageDetailView.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import SwiftUI

struct ImageDetailView: View {
    var item: ImageDataModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: item.media.thumbnail)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    Text("We're sorry, an error ocurred while fetching image. Error: \(error.localizedDescription)")
                    Text("item link: \(item.link)")
                default:
                    HStack {
                        Text("We're sorry, an error ocurred while fetching image.")
                    }
                }
            }
            .padding()
            Text("Title: \(item.title)")
                .font(.title)
                .padding()
            if let author = item.author.slice(from: "(", to: ")") {
                Text("Author: \(author)")
            }
            
        }
    }
}
