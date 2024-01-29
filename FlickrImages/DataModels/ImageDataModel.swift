//
//  ImageDataModel.swift
//  FlickrImages
//
//  Created by Andrea Martin  on 1/29/24.
//

import Foundation

struct ImageDataModel: Codable {
    var title: String
    var media: MediaDataModel
    var link: String
    var description: String?
    var author: String
}
