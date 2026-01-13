import SwiftUI
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String  = ""
    @Published var validationErrorText: String = ""
    @Published var textError: String = ""
    
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
            Task {await logingIn()}
            }
    }
    
    func logingIn() async {
        let login =  Login()
        login.email = email
        login.password = password
        
        guard let encoder = try? JSONEncoder().encode(login) else {
            textError = "Erro ao tentar logar"
            return
        }
        let url = URL(string: "https://template-onboarding-node-sjz6wnaoia-uc.a.run.app/authenticate")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = encoder
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoded = try JSONDecoder().decode(Login.LoginResponse.self, from: data)
            login.token = decoded.data.token
            UserDefaults.standard.set(login.token, forKey: "token")
        } catch {
            textError = ("Erro ao auntenticar: \(error.localizedDescription)")
        }
    }
}
