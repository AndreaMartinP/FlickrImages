//
//  NetworkEndpoint.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

struct NetworkEndpoint {
    enum Route {
        case photoWithTag(tagString: String)
        
        func createUrl() -> URL? {
            switch self {
            case .photoWithTag(tagString: let tagString):
                let path = "/services/feeds/photos_public.gne"
                let queryItemFirst = URLQueryItem(name: "format", value: "json")
                let queryItemSecond = URLQueryItem(name: "nojsoncallback", value: "1")
                var urlComponents = URLComponents(url:NetworkEndpoint().baseURL, resolvingAgainstBaseURL: true)
                urlComponents?.path = path
                var urlQueryItems = [queryItemFirst, queryItemSecond]
                let tagQuery = URLQueryItem(name: "tags", value: tagString)
                urlQueryItems.append(tagQuery)
                urlComponents?.queryItems = urlQueryItems
                return urlComponents?.url

            }
        }
    }
    let baseURL = URL(string: "https://api.flickr.com")!
}
