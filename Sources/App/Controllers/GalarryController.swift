//
//
//
//  Created by Jude Alatawi on 14/03/2023.
//

import Fluent
import Vapor

struct GalarryController : RouteCollection{
    
    func boot(routes: Vapor.RoutesBuilder) throws {
                let comment = routes.grouped("comments")
        
        
        comment.get(use: index)
        
        
        comment.post(use: create)
        comment.delete(":id",use: delete)
        comment.get(":id",use: getById)
        comment.put(use:update)

        
    }
    func index(req: Request) async throws -> [Comment]  {
        try await Comment.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Comment{
        let comment = try req.content.decode(Comment.self)
        try await comment.save(on: req.db)
        return comment
    }

    func getById (req:Request) async throws -> Comment {
         guard let comment = try await Comment.find(req.parameters.get("id"), on: req.db)
        else {throw Abort(.notFound)}
        
        return comment
            
    }
   
    func delete(req : Request) async throws -> HTTPStatus {
        guard let comment = try await Comment.find(req.parameters.get("id"), on : req.db)
        else
        {
            throw Abort(.notFound)
        }
        try await comment.delete(on : req.db)
        return .noContent
    }
    
    func update (req: Request) async throws -> HTTPStatus {
            let newComment = try req.content.decode(Comment.self)
            guard let comment = try await Comment.find(newComment.id, on: req.db) else {
                throw Abort (.notFound)
            }
            comment.comment = newComment.comment
            try await comment.save(on : req.db)
            
            return .ok
        }
    


    
}
