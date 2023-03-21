//
//  
//
//  Created by Jude Alatawi on 20/03/2023.
//

import Fluent
import Vapor

final class Comment: Model,Content{
    static let schema = "comments"
    
    @ID(key: "id") var id: UUID?
    @Field(key: "comment") var comment : String
    
    @Parent(key: "photo_id") var photo_id: Photo
    
    init() {}
    
    init(id:UUID? = nil, comment: String, photo_id:Photo){
        self.id = id
        self.comment = comment
        self.$photo_id.id = photo_id.id!
    }
    
}
