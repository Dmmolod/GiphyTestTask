//
//  GiphyObjectModel.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

struct GiphyObjectModel: Decodable {
    let url: String
    let images: GiphyImagesObjectModel
}
