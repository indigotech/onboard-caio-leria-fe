class Login: Codable{
    var email: String = ""
    var password: String = ""
    var token: String = ""
    var errorMessage: String = ""
    
    struct LoginResponse: Codable {
        let data: TokenContainer
    }

    struct TokenContainer: Codable {
        let token: String
    }
    
    struct LoginError: Codable {
        let errors: [ErrorResponse]?
    }
    struct ErrorResponse: Codable {
        let name: String
        let code: Int
        let message: String
    }
}
