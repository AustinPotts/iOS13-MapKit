//
//  Quake.swift
//  Quakes
//
//  Created by Austin Potts on 3/12/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation


class Quake: NSObject, Decodable {
    
    //mag
    //place
    //time
    //lat
    //long
    
    
    let magnitude: Double?
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double
    
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case properties
        case place
        case time
        case geometry
        case coordinates
    }
    
    required init(from decoder: Decoder) throws {
        //Containers
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let propertiesContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        let geometry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        var coordinates = try geometry.nestedUnkeyedContainer(forKey: .coordinates)
        
        //Attributes
        self.magnitude = try? propertiesContainer.decode(Double.self, forKey: .magnitude)
        self.place = try propertiesContainer.decode(String.self, forKey: .place)
        self.time = try propertiesContainer.decode(Date.self, forKey: .time)
        
        self.longitude = try coordinates.decode(Double.self)
        self.latitude = try coordinates.decode(Double.self)
        
        super.init()
    }
    
    
    
}
