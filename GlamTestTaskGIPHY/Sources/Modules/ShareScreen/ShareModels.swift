//
//  ShareModels.swift
//  GlamTestTaskGIPHY
//
//  Created by Дмитрий Молодецкий on 30.01.2023.
//

import UIKit

enum ShareType: String, CaseIterable {
    case iMessage
    case whatsapp
    case facebook
    case twitter
    case instagram
    case snapChat
    
    var image: UIImage? {
        return UIImage(named: "ShareGroup/" + self.rawValue)
    }
    
    var schema: String {
        return "whatsapp"
    }
}
