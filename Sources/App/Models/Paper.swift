//
//  Paper.swift
//  App
//
//  Created by Sebastian on 7/16/18.
//

import Foundation
import Vapor

struct Paper: Parameter, Content {
    var id: Int
    var title: String
    
    init(id: String) {
        if let intID = Int(id) {
            self.id = intID
            self.title = "Custom parameters rock for papers!"
        } else {
            self.id = 0
            self.title = "Unknown paper"
        }
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Future<Paper?> {
        return Future.map(on: container) {
            Paper(id: parameter)
        }
    }
}


