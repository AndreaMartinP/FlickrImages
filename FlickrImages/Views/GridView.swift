//
//  GridView.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import SwiftUI

struct GridView: View {
    @StateObject var viewModel = GridViewViewModel()
    private static let initialColumns = 3
    @State private var isSearching = false
    @State private var gridColumns = Array(repeating: GridItem(.flexible(minimum: .leastNonzeroMagnitude, maximum: .greatestFiniteMagnitude)), count: initialColumns)
    @State private var numColumns = initialColumns
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns) {
                ForEach($viewModel.searchResults, id:\.id) { item in
                    GeometryReader { geo in
                        NavigationLink(destination: ImageDetailView(item: item.wrappedValue)) {
                            GridItemView(size: geo.size.width, item: item.wrappedValue)
                        }
                    }
                }
                .cornerRadius(8.0)
                .aspectRatio(1, contentMode: .fit)
            }
            .padding()
        }
        .task {
            viewModel.fetchData()
        }
    }
}
