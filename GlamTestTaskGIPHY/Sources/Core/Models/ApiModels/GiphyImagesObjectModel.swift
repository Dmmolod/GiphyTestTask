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
    
    enum CodingKeys: String, CodingKey {
        case original
        case medium = "downsized_medium"
    }
}

struct GiphyImagesMediumModel: Decodable {
    let url: String
    let height: String?
    let width: String?
}

struct GiphyImagesOriginalModel: Decodable {
    let url: String
}
