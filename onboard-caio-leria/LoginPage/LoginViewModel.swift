import SwiftUI
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String  = ""
    @Published var loginText: String = ""
    var isPasswordValid: Bool {
        let passwordSize = password.count >= 7
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordSize && passwordTest.evaluate(with: password)
    }
    var isPasswordEmpty: Bool {
        password.isEmpty
    }
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    var isEmailEmpty: Bool {
        email.isEmpty
    }
    var isLoginEnable: Bool {
        isEmailEmpty == false && isPasswordEmpty == false && isEmailValid && isPasswordValid
    }
    func login() {
        if isLoginEnable {
            loginText = "Login feito com sucesso"
        } else{
            loginText = "Login falhou"
        }
    }
}
