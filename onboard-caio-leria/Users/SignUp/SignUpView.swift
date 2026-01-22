import SwiftUI

struct SignUpView: View {
    @StateObject var signUpViewModel: SignUpViewModel = .init()
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            H1(text: "Cadastro")
            Form {
                InputText(title: "Nome", placeholder: "Nome e sobrenome", input: $signUpViewModel.user.name)
                if !signUpViewModel.isNameValid && !signUpViewModel.user.name.isEmpty {
                    Text("Digite seu nome e sobrenome")
                        .font(Font.caption.italic())
                        .foregroundColor(.red)
                }
                InputText(title: "E-mail", placeholder: "Email@email.com", input: $signUpViewModel.user.email)
                if !signUpViewModel.isEmailValid && !signUpViewModel.user.email.isEmpty {
                    Text("Digite um email válido")
                        .font(Font.caption.italic())
                        .foregroundColor(.red)
                }
                InputText(title: "Senha", placeholder: "", input: $signUpViewModel.user.password)
                if !signUpViewModel.isPasswordValid && signUpViewModel.user.password != "" {
                    Text("A senha deve conter pelo menos 7 caracteres e pelo menos 1 número")
                        .font(Font.caption.italic())
                        .foregroundColor(.red)
                }
                InputText(title: "Telefone", placeholder: "11999999999", input: $signUpViewModel.user.phone)
                if !signUpViewModel.isPhoneValid && !signUpViewModel.user.phone.isEmpty {
                    Text("Digite um número válido")
                        .font(Font.caption.italic())
                        .foregroundColor(.red)
                }
                DatePicker(
                    "Data de nascimento",
                    selection: $signUpViewModel.user.birthDate,
                    displayedComponents: .date
                )
                if !signUpViewModel.isBirthDateValid {
                    Text("Coloque uma data válida")
                        .font(Font.caption.italic())
                        .foregroundColor(.red)
                }
                Picker("Cargo", selection: $signUpViewModel.user.role) {
                    ForEach(SignUpUser.Roles.allCases, id: \.self) { role in
                        Text(role.rawValue).tag(role)
                    }
                }
                .pickerStyle(.segmented)
                Button("Cadastre") {
                    signUpViewModel.SignUp()
                }
                .frame(maxWidth: .infinity)
                .disabled(!signUpViewModel.isSignUpValid)
                .onChange(of: signUpViewModel.isSignupSuccessful) { _, newValue in
                    if newValue {
                        path.append("UsersView")
                    }
                }
                if !signUpViewModel.textError.isEmpty {
                    Text(signUpViewModel.textError)
                }
            }
        }
    }
}
