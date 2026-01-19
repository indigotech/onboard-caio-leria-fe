import Foundation

struct User: Codable, Identifiable {
    var id: String?
    var name: String
    var email: String
    var password: String
    var birthDate: Date 
    var phone: String
    var role: Roles
    
    enum Roles: String, Codable, CaseIterable {
        case user = "User"
        case admin = "Admin"
    }
}

struct UserResponse: Codable {
    let data: DataContainer

    struct DataContainer: Codable {
        let nodes: [User]
        let pageInfo: PageInfo
    }

    struct PageInfo: Codable {
        let limit: Int
        let offset: Int
        let hasNextPage: Bool
        let hasPreviousPage: Bool
    }
}
