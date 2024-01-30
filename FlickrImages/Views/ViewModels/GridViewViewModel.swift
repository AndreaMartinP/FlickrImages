//
//  GridViewViewModel.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

class GridViewViewModel: ObservableObject {
    @Published var searchResults = [ImageDataModel]()
    @Published var searchText = ""
    private var network: Networkable
    
    init(network: Networkable = Networking.shared) {
        self.network = network
    }
    
    @MainActor
    func fetchData() {
        Task {
            let result: ImagesData = try await network.fetchAndDecode(route: .photoWith(tag: "porcupine"))
            searchResults = result.items
        }
    }
}
