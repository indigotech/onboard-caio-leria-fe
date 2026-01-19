import Combine
import Foundation
import Moya
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var validationErrorText: String = ""
    @Published var textError: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    let provider = MoyaProvider<LoginService>()
    
    var isPasswordValid: Bool {
        let passwordSize = password.count >= 7
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordSize && passwordTest.evaluate(with: password) && !password.isEmpty
    }
    
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email) && !email.isEmpty
    }
    
    func validatingCredentials() {
        if !isEmailValid && !isPasswordValid {
            validationErrorText = "Credenciais inválidas"
        } else if !isPasswordValid {
            validationErrorText = "Senha inválida"
        } else if !isEmailValid {
            validationErrorText = "Digite um email válido"
        } else {
            performLogin()
        }
    }
    
    func performLogin() {
        var loginData = Login()
        loginData.email = email
        loginData.password = password
        isLoading=true
        provider.request(.login(loginData)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    if let user = try? JSONDecoder().decode(LoginResponse.self, from: response.data) {
                        DispatchQueue.main.async {
                            self.textError = ""
                            UserDefaults.standard.set(user.data.token, forKey: "token")
                            self.isLoading = false
                            self.isLoggedIn = true
                        }
                    }
                } else {
                    let decoder = JSONDecoder()
                    if let error = try? decoder.decode(LoginError.self, from: response.data) {
                        let errorMessage = error.errors?.first?.message ?? "erro desconhecido"
                        DispatchQueue.main.async {
                            self.textError = errorMessage
                            self.isLoading = false
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.textError = error.localizedDescription
                }
            }
        }
    }
}
