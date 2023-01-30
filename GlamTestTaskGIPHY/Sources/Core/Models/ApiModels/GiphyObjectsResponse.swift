//
//  GiphyTrandingResponse.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 28.01.2023.
//

import Foundation

struct GiphyObjectsResponse: Decodable {
    let data: [GiphyObjectModel]
    let pagination: GiphyPagintionModel
}
