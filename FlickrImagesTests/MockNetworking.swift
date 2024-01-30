//
//  MockNetworking.swift
//  FlickrImagesTests
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation
@testable import FlickrImages

class MockNetworking: Networkable {
    enum MockError: Error {
        case noData
    }
    
    var fetchAndDecodeReturnData = [Data]()
    func fetchAndDecode<T>(route: FlickrImages.NetworkEndpoint.Route) async throws -> T where T : Decodable, T : Encodable {
        guard let first = fetchAndDecodeReturnData.first else {
            throw MockError.noData
        }
        return try JSONDecoder().decode(T.self, from: first)
    }
}
