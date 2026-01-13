import Foundation
import Moya
import Alamofire

let SERVER_BASE_URL: String = "https://template-onboarding-node-sjz6wnaoia-uc.a.run.app"

enum LoginService {
    case login(Login)
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: SERVER_BASE_URL)!
        }
        
        var path: String {
            switch self {
            case .login: return "/authenticate"
            }
        }
        
        var method: Moya.Method {
            return .post
        }
        
        var task: Task {
            switch self {
            case .login(let loginData):
                return .requestJSONEncodable(loginData)
            }
        }
        
        var headers: [String: String]? {
            return ["Content-Type": "application/json"]
        }
}
