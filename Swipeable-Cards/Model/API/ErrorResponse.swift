//
//  ErrorResponse.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
    public var domain: String {
        return ""
    }
    
    public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
        return try ErrorResponse(code: code, message: json[""]^)
    }
    
    public var code: Int
    
    public var title: String {
        return "Error"
    }
    
    public var messages: [String] {
        return [""]
    }
    
    public var message: String
}
