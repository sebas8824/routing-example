//
//  AdminCollection.swift
//  App
//
//  Created by Sebastian on 7/16/18.
//

import Foundation
import Vapor

final class AdminCollection: RouteCollection {
    func boot(router: Router) throws {
        let article = router.grouped("press", Int.parameter)
        
        article.get("read") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Reading article \(num)"
        }
        
        article.get("edit") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Editing article \(num)"
        }
    }
}
