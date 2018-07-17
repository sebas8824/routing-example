//
//  Article.swift
//  App
//
//  Created by Sebastian on 7/16/18.
//

import Foundation
import Vapor

struct Article: Parameter {
    var id: Int
    var title: String
    
    init(id: String) {
        if let intID = Int(id) {
            self.id = intID
            self.title = "Custom parameters rock!"
        } else {
            self.id = 0
            self.title = "Unknown article"
        }
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Article {
        return Article(id: parameter)
    }
}


