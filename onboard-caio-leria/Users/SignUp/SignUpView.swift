import SwiftUI

struct SignUpView: View {
    @StateObject var signUpViewModel: SignUpViewModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField(
                        "Nome",
                        text: $signUpViewModel.user.name
                    )
                    
                    TextField(
                        "E-mail",
                        text: $signUpViewModel.user.email
                    )
                    
                    TextField(
                        "Senha",
                        text: $signUpViewModel.user.password
                    )
                    
                    TextField(
                        "Telefone",
                        text: $signUpViewModel.user.phone
                    )
                    
                    DatePicker(
                        "Data de nascimento",
                        selection: $signUpViewModel.user.birthDate,
                        displayedComponents: .date
                    )
                    
                    Picker("Cargo", selection: $signUpViewModel.user.role) {
                        ForEach(User.Roles.allCases, id: \.self) { role in
                            Text(role.rawValue).tag(role)
                        }
                    }
                    .pickerStyle(.segmented)
                    Button("Cadastre") {
                    }
                }
            }
            .navigationTitle(Text("Sign Up"))
        }
    }
}

#Preview {
    SignUpView()
}
