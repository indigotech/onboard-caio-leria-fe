import Alamofire
import Foundation
import Moya

let SERVER_BASE_URL: String = "https://template-onboarding-node-sjz6wnaoia-uc.a.run.app"

enum LoginService {
    case login(Login)
    case fetchUser(offset: Int, limit: Int)
    case signUp(SignUpUser)
    case userDetails(id: String)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: SERVER_BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .login: return "/authenticate"
        case .fetchUser: return "/users"
        case .signUp: return "/users"
        case .userDetails (let id): return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .fetchUser:
            return .get
        case .signUp:
            return .post
        case .userDetails:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let loginData):
            return .requestJSONEncodable(loginData)
        case .fetchUser(let offset, let limit):
            return .requestParameters(parameters: ["offset": offset, "limit": limit],
                                      encoding: URLEncoding.queryString)
        case .signUp(let userData):
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter
            }()
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            return .requestCustomJSONEncodable(userData, encoder: encoder)
        case .userDetails(let userDetailData):
            return .requestJSONEncodable(userDetailData)
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
                "Authorization": token
            ]
        case .signUp:
            let token = UserDefaults.standard.string(forKey: "token")?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return ["Content-Type": "application/json",
                    "Authorization": token]
        case .userDetails:
            let token = UserDefaults.standard.string(forKey: "token")?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return ["Content-Type": "application/json",
                    "Authorization": token]
        }
    }
}
