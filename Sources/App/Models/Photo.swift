//
//
//
//  Created by Jude Alatawi on 14/03/2023.
//

import Fluent
import Vapor



final class Photo: Model,Content{
    static let schema = "photos"
    @ID(key: "id")
    var id: UUID?
    
    @Field(key: "photo")
    var photo : String
    
    @Children(for: \.$photo_id)
    var photo_id:[Comment]

    
    init() {}
    
    init(id:UUID? = nil, photo: String){
        self.id = id
        self.photo = photo
    }
    
}
