//
//  SignUpViewModel.swift
//  OnboardCaioLeria
//
//  Created by Taqtile on 16/01/26.
//
import Combine
import Foundation
import Moya
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var user: User = .init(name: "", email: "",  password: "", birthDate: Date(), phone: "", role: .user)
    
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
        let birthDateRegex = "^[0-9]{2}\\/[0-9]{2}\\/[0-9]{4}$"
        let birthDateTest = NSPredicate(format: "SELF MATCHES %@", birthDateRegex)
        return birthDateTest.evaluate(with: user.birthDate) && user.birthDate <= Date()
    }
    
    var isNameValid: Bool {
        var isNameFull: Bool {
            let nameParts = user.name.split(separator: " ")
            return nameParts.count >= 2
        }
        return !user.name.isEmpty && isNameFull
    }
}
