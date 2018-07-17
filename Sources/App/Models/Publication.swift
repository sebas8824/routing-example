//
//  Publication.swift
//  App
//
//  Created by Sebastian on 7/16/18.
//

import Foundation
import Vapor

struct Publication: Parameter, Content {
    var id: Int
    var title: String
    
    init(id: Int) {
        self.id = id
        self.title = "Custom publications rock!"
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Publication {
        if let id = Int(parameter) {
            return Publication(id: id)
        } else {
            throw Abort(.badRequest)
        }
    }
}
