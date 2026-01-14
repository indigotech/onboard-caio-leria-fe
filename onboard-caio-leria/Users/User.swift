import Foundation

struct User: Codable{
    var name: String
    var email: String
}

struct UserResponse: Codable{
    var users: [User]
}

