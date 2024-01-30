//
//  Networking.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

protocol Networkable {
    func fetchAndDecode<T: Codable>(route: NetworkEndpoint.Route) async throws -> T
}

class Networking: Networkable {
    
    static let shared = Networking()
    private var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAndDecode<T>(route: NetworkEndpoint.Route) async throws -> T where T : Decodable, T : Encodable {
        let url = try route.createUrl()
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data)
        let newData = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted, .withoutEscapingSlashes])
        return try JSONDecoder().decode(T.self, from: newData)
    }
    
}
