//
//  InfoRouter.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation

public enum InfoRouter: BaseRouter {
    case fetchData
    
    public var keypathToMap: String? {
        switch self {
        case .fetchData:
            return "data"
        }
    }
}
