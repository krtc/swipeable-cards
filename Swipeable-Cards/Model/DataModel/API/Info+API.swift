//
//  Info+API.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation
import FoxAPIKit
import Alamofire
import JSONParsing

public typealias APICompletion<T> = (APIResult<T>) -> Void

extension Info {
    
    public static func fetchData(completion: @escaping APICompletion<[Info]>) {
        
        func handleJson(_ json: JSON) {
            let keyPathToMap = json.jsonAtKeyPath(keypath: "data")
            
            if let data = keyPathToMap.array {
                completion(.success(data.map { Info(json: $0) }))
            }
        }
        
        Alamofire.request(APIConfig.baseURL).responseString { (response) in
            if response.result.isSuccess {
                if var string = response.result.value {
                    string.remove(at: string.startIndex)
                    let json = JSON(parseJSON: string)
                    handleJson(json)
                }
            } else if let error = response.error {
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
        }
    }
}


class CustomError: AnyError {
    
    var code: Int {
        return 0
    }
    
    var domain: String {
        return ""
    }
    
    var message: String
    init(message: String) {
        self.message = message
    }
    
}
