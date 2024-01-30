//
//  GridViewViewModel.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Combine
import Foundation

class GridViewViewModel: ObservableObject {
    @Published var searchResults = [ImageDataModel]()
    private var network: Networkable
    private var cancellables = Set<AnyCancellable>()
    
    init(network: Networkable = Networking.shared) {
        self.network = network
    }
    
    @MainActor
    func fetchData(text: String) {
        Task {
            let result: ImagesData = try await network.fetchAndDecode(route: .photoWith(tag: text))
            searchResults = result.items
        }
    }
}
