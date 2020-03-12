//
//  QuakeResults.swift
//  Quakes
//
//  Created by Austin Potts on 3/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class QuakeResults: Decodable {
    let quakes: [Quake]
    
    enum CodingKeys: String, CodingKey {
        case quakes = "features"
    }
    
}
