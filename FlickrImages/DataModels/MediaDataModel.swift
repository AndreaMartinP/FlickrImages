//
//  MediaDataModel.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

struct MediaDataModel: Codable {
    var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "m"
    }
}
