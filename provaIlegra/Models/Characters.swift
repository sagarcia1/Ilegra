//
//  Characters.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 23/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit

class Characters: NSObject {
    private(set) var list: [Character]
    
    required init(map: Mapper) throws {
        list = map.optionalFrom(field: "data.results") ?? []
    }
    
}

public class Character: Mappable {
    public private(set) var id: Double?
    public private(set) var name: String?
    public private(set) var description: String?
    public private(set) var resourceURI: String?
    public private(set) var thumbnail: Thumbnail?
    
    
    required public init(map: Mapper) throws {
        id  = map.optionalFrom(field: "id")
        name  = map.optionalFrom(field: "name")
        description = map.optionalFrom(field: "description")
        resourceURI = map.optionalFrom(field: "resourceURI")
        thumbnail = map.optionalFrom(field: "thumbnail")
        
    }
}

public class Thumbnail: Mappable {
    public private(set) var path: String?
    public private(set) var extensionThumb: String?
    
    required public init(map: Mapper) throws {
        path  = map.optionalFrom(field: "path")
        extensionThumb  = map.optionalFrom(field: "extension")
    
    }
}
