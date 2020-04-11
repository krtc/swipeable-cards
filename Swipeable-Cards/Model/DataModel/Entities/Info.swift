//
//  Info.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation
import JSONParsing

public final class Info {
    public var id: String
    public var text: String
    
    public init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
    public init(json: JSON) {
        self.id = json["id"].stringValue
        self.text = json["text"].stringValue
    }
}

//extension Info: JSONParseable {
//    public static func parse(_ json: JSON) throws -> Info {
//        return try Info(id: json["id"]^,
//                        text: json["text"]^)
//    }
//}
