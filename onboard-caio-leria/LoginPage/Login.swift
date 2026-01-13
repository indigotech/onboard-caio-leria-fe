class Login: Codable{
    var email: String = ""
    var password: String = ""
    var token: String = ""
    
    struct LoginResponse: Codable {
        let data: TokenContainer
    }

    struct TokenContainer: Codable {
        let token: String
    }
}
