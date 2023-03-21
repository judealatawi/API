# **Photos and Comments Anonymously Vapor API**
This is an Vapor API that allows users to share photos and comments anonymously. The API supports the four main CRUD functions (Create, Read, Update, and Delete) for both photos and comments.

# **Endpoints**
## Photo Endpoints

1- Create:  Create a new photo.

2- Read: Retrieve all photos and assosiated comments or retrieve a specific photo by ID.

3- Update: Update an existing photo.

4- Delete:  Delete a photo by ID.

- Create a new photo

```
POST /photos
```
- Read all the photos and assosiated comments.

```
GET /photos
```
- Read a specific photo

```
GET /photos/<photo id>
 ```

- Update a photo

```
PUT /photos
 ```

- Deletes a specific photo by ID

```
 DELETE  /photos/<photos id>
 ```

## Comment **Endpoints**

1- Create:  Create a new comment.
2- Read: Retrieve all comments and assosiated photo or retrieve a specific comment by ID.
3- Update: Update an existing comment.
4- Delete:  Delete a comment by ID.

- Create a new comment

```
POST /comments
```
- Read all the comments under all the photos.

```
GET /comments
```
- Read a specific comment

```
GET /comments/<comment id>
 ```

- Update a comment

```
PUT /comments
 ```

- Deletes a specific comment by ID

```
 DELETE  /comments/<comment id>
 ```
----
# **Models**
######The API has two models: Photo and Comment.


## Photo Model
```swift
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
```
    
## Comment Model
 ```swift
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
```
----
# **Usage**
######To use this API, you will need to have Vapor installed. If you don't have Vapor installed, you can follow the installation guide link [Here](https://docs.vapor.codes/install/macos/).

###### Once you have Vapor installed, you can clone the repository by running the following command in your terminal:
```
git clone https://github.com/judealatawi/API.git
```
######Next, navigate to the cloned repository and run the following command to build and start the API server:
```
vapor run
```
    
######This will start the API server, and you can then access the endpoints via a client such as Postman or cURL.

----
# **Contribution**
[Jude Alatawi](https://github.com/judealatawi)
[Hajar Nashi]()
[Sumaya Alturki
]()
