//
//  MainModels.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import Foundation

enum MainSectionType: Hashable {
    case trandings
    case category(name: String)
}

struct MainPresenterModel {
    var items: [GifModel]
    var offset: Int32
}

struct MainGifCollectionViewModel {
    let gifLink: String
    let fetchGifAction: ((String, @escaping (Data?) -> ()) ->())?
}
