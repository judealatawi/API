
//  
//
//  Created by Jude Alatawi on 20/03/2023.
//

import Fluent
struct CreateGalary : Migration {
    
    func prepare(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
            db.schema(Photo.schema)
                .id()
                .field("photo", .string, .required)
                .create(),
            db.schema(Comment.schema)
                .id()
                .field("comment", .string, .required)
                .field("photo_id", .uuid, .required,.references("photos", "id"))
                .create()
        ])
    }
 
    
    
    func revert(on db: Database) -> EventLoopFuture<Void> {
        db.eventLoop.flatten([
                    db.schema(Photo.schema).delete(),
                    db.schema(Comment.schema).delete()
                    
                ])
    }

    
}
