import Foundation
import Moya
import Alamofire

let SERVER_BASE_URL: String = "https://template-onboarding-node-sjz6wnaoia-uc.a.run.app"

enum LoginService {
    case login(Login)
    case fetchUser
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: SERVER_BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .login: return "/authenticate"
        case .fetchUser: return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .fetchUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let loginData):
            return .requestJSONEncodable(loginData)
        case .fetchUser:
            return .requestParameters(parameters: ["offset": 0, "limit": 20],
            encoding: URLEncoding.queryString )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        case .fetchUser:
            let token = UserDefaults.standard.string(forKey: "token")?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return [
                "Content-Type": "application/json",
                "Authorization": token]
        }
    }
}
