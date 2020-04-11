//
//  SwipeableCardsAPIClient.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

class SwipeableCardAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = SwipeableCardAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        enableLogs = true
        #else
        enableLogs = false
        #endif
        self.authHeaders = AuthHeaders(authorizationToken: "")
    }
    
    override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
        return self.authHeaders
    }
}
