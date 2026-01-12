import SwiftUI
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String  = ""
    @Published var validationErrorText: String = ""
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
 
    var isLoginEnable: Bool {
      isEmailValid && isPasswordValid
    }
    
    func login() {
        if !isLoginEnable {
            if !isEmailValid && !isPasswordValid {
                validationErrorText = "Credenciais inválidas"
            } else if !isPasswordValid {
                validationErrorText = "Senha inválida"
            } else if !isEmailValid {
                validationErrorText = "Email inválido"
            }
        }
    }
}
