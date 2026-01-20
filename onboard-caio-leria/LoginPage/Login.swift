import Alamofire
import Moya

struct Login: Codable {
    var email: String = ""
    var password: String = ""
}

struct LoginResponse: Codable {
    let data: TokenContainer
    struct TokenContainer: Codable {
        let token: String
    }
}

struct LoginError: Codable {
    let errors: [ErrorResponse]?

    struct ErrorResponse: Codable {
        let name: String
        let code: Int
        let message: String
    }
}
