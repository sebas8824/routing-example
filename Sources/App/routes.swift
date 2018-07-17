import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello", "world") { req in
        return "Hello, world!"
    }
    
    // Parameters usage
    router.get("greetings", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Greetings, \(name)!"
    }
    
    // Custom types as parameters
    router.get("articles", Article.parameter) { req -> String in
        let article = try req.parameters.next(Article.self)
        return "Loading article: \(article.title)"
    }
    
    // Sending back as JSON
    router.get("posts", Post.parameter, "json") { req -> Post in
        return try req.parameters.next(Post.self)
    }
    
    // MARK: Complexity #1: Working with futures
    router.get("paper", Paper.parameter) { req -> Future<Paper> in
        let paper = try req.parameters.next(Paper.self)
        return paper.map(to: Paper.self) { paper in
            guard let paper = paper else {
                throw Abort(.badRequest)
            }
            return paper
        }
    }
    
    // MARK: Complexity #2: Dealing with missing data
    router.get("publication", Publication.parameter) { req -> Publication in
        return try req.parameters.next(Publication.self)
    }
    
    // MARK: Grouping Routes
    // Grouping router.group
    router.group("article", Int.parameter) { group in
        group.get("read") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Reading article \(num)"
        }
        
        group.get("edit") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Editing article \(num)"
            
        }
    }
    
    // Grouping by RouteGroup object
    let posts = router.grouped("posts", Int.parameter)
    
    posts.get("read") { req -> String in
        let num = try req.parameters.next(Int.self)
        return "Reading post \(num)"
    }
    
    posts.get("edit") { req -> String in
        let num = try req.parameters.next(Int.self)
        return "Editing article \(num)"
    }
    
    // MARK: Router collections
    try router.grouped("admin").register(collection: AdminCollection())
    
}
