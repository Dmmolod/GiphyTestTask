//
//  GiphyImagesObjectModel.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

struct GiphyImagesObjectModel: Decodable {
    let original: GiphyImagesOriginalModel
    let medium: GiphyImagesMediumModel
    let small: GiphyImagesSmallModel
    
    enum CodingKeys: String, CodingKey {
        case original
        case medium = "downsized_medium"
        case small = "downsized_small"
    }
}

struct GiphyImagesMediumModel: Decodable {
    let url: String
}

struct GiphyImagesSmallModel: Decodable {
    let height: String
    let width: String
}

struct GiphyImagesOriginalModel: Decodable {
    let url: String
}
