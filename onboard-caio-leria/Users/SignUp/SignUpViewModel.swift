import Combine
import Foundation
import Moya
import RxMoya
import RxSwift
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var user: SignUpUser = .init(email: "", name: "", password: "", birthDate: Date(), phone: "", role: .user)
    @Published var textError: String = ""
    @Published var isSignUp: Bool = false
    let provider = MoyaProvider<LoginService>(
    )
    let disposeBag = DisposeBag()
    
    var isPasswordValid: Bool {
        let passwordSize = user.password.count >= 7
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordSize && passwordTest.evaluate(with: user.password) && !user.password.isEmpty
    }
    
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: user.email) && !user.email.isEmpty
    }

    var isPhoneValid: Bool {
        let phoneRegex = "^[0-9]{10,11}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: user.phone) && !user.phone.isEmpty
    }
    
    var isBirthDateValid: Bool {
        return user.birthDate <= Date()
    }
    
    var isNameValid: Bool {
        var isNameFull: Bool {
            let nameParts = user.name.split(separator: " ")
            return nameParts.count >= 2
        }
        return !user.name.isEmpty && isNameFull
    }
    
    var isSignUpValid: Bool {
        return isEmailValid && isPasswordValid && isNameValid && isPhoneValid && isBirthDateValid
    }
    
    func SignUp() {
        textError = ""
        isSignUp = false
        provider.rx.request(LoginService.signUp(user))
            .filterSuccessfulStatusCodes()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] _ in
                self?.isSignUp = true
            }, onFailure: { [weak self] error in
                if let moyaError = error as? MoyaError, let reponse = moyaError.response {
                    let errorResponse = try? reponse.map(SignUpError.self)
                    self?.textError = errorResponse?.errors?.first?.message ?? "Algo deu errado"
                }
            }).disposed(by: disposeBag)
    }
}
