//
//  NetworkEndpoint.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

struct NetworkEndpoint {
    static let baseURL = URL(string: "https://api.flickr.com")!
    
    enum EndpointError: Error {
        case couldNotCreateComponents
        case invalidURL
    }
    
    enum Route {
        case photoWith(tag: String)
        
        var path: String {
            switch self {
            case .photoWith(_):
                "/services/feeds/photos_public.gne"
            }
        }
        
        func createUrl() throws -> URL {
            switch self {
            case .photoWith(tag: let tag):
                guard var urlComponents = URLComponents(url:NetworkEndpoint.baseURL, resolvingAgainstBaseURL: true) else {
                    throw EndpointError.couldNotCreateComponents
                }
                urlComponents.path = path
                var urlQueryItems = defaultQueryItems
                urlQueryItems.append(URLQueryItem(name: "tags", value: tag))
                urlComponents.queryItems = urlQueryItems
                guard let url = urlComponents.url else {
                    throw EndpointError.invalidURL
                }
                return url
            }
        }
        
        var defaultQueryItems: [URLQueryItem] {
            let format = URLQueryItem(name: "format", value: "json")
            let nojsoncallback = URLQueryItem(name: "nojsoncallback", value: "1")
            return [format, nojsoncallback]
        }
    }
    
}
