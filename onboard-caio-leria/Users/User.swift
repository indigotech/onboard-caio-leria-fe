import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var birthDate: String
    var phone: String
    var role: String
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
