//
//
//
//  Created by Jude Alatawi on 14/03/2023.
//

import Fluent
import Vapor

struct PhotoController : RouteCollection{
    
    func boot(routes: RoutesBuilder) throws {
                let photos = routes.grouped("photos")
        photos.get(use: index)
        
        
        photos.post(use: create)
        photos.delete(":id",use: delete)
        photos.get(":id",use: getById)
        photos.put(use:update)

    }

    func index(req: Request) async throws -> [Photo]  {
        try await Photo.query(on: req.db).with(\.$photo_id).all()
    }
    
    
    func create(req: Request) async throws -> Photo{
        let photo = try req.content.decode(Photo.self)
        try await photo.save(on: req.db)
        return photo
    }

    func getById (req:Request) async throws -> Photo {
         guard let photo = try await Photo.find(req.parameters.get("id"), on: req.db)
        else {throw Abort(.notFound)}
        
        return photo
            
    }

    func delete(req : Request) async throws -> HTTPStatus {
        guard let photo = try await Photo.find(req.parameters.get("id"), on : req.db)
        else
        {
            throw Abort(.notFound)
        }
        try await photo.delete(on : req.db)
        return .noContent
    }

    
    func update(req: Request) async throws -> HTTPStatus {
            let newphoto = try req.content.decode(Photo.self)
            guard let photo = try await Photo.find(newphoto.id, on: req.db) else {
                throw Abort (.notFound)
            }
            photo.photo = newphoto.photo
            try await photo.update(on : req.db)

            return .ok
        }
    
    
    

    
}
