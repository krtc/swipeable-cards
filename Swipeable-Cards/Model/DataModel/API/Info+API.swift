//
//  Info+API.swift
//  Model
//
//  Created by kartic on 11/04/20.
//  Copyright © 2020 Kartik. All rights reserved.
//

import Foundation
import FoxAPIKit

extension Info {
    public func fetchData(completion: @escaping APICompletion<[Info]>) {
        SwipeableCardAPIClient.shared.request(InfoRouter.fetchData) { (result: APIResult<ListResponse<Info>>) in
            switch result {
            case .success(let infoData):
                completion(.success(infoData.list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
