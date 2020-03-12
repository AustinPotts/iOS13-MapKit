//
//  Quake.swift
//  Quakes
//
//  Created by Austin Potts on 3/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation


class Quakes: NSObject, Decodable {
    
    //mag
    //place
    //time
    //lat
    //long
    
    
    let magnitude: Double
//    let place: String
//    let time: Date
//    let latitiude: Double
//    let longitude: Double
    
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case properties
    }
    
    required init(from decoder: Decoder) throws {
        //Containers
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let propertiesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        
        //Attributes
        self.magnitude = try propertiesContainer.decode(Double.self, forKey: .magnitude)
        
        
        
        super.init()
    }
    
    
    
}
