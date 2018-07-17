//
//  Post.swift
//  App
//
//  Created by Sebastian on 7/16/18.
//

import Foundation
import Vapor

struct Post: Parameter, Content {
    var id: Int
    var title: String

    init(id: String) {
        if let intID = Int(id) {
            self.id = intID
            self.title = "Custom as a JSON parameters rock!"
        } else {
            self.id = 0
            self.title = "Unknown JSON post result"
        }
    }

    static func resolveParameter(_ parameter: String, on container: Container) throws -> Post {
        return Post(id: parameter)
    }
}
