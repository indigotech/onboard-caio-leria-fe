import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = .init()
    @StateObject private var usersViewModel: UsersViewModel = .init()
    @Binding var path: NavigationPath
    var body: some View {
        H1(text: "Bem-vindo à Taqtile")
        InputText(title: "Login",placeholder: "seuemail@email.com", input: $viewModel.email)
        VStack(spacing: 5) {
            Label(text:"Senha")
            SecureField(
                "Senha",
                text: $viewModel.password
            )
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(.gray), lineWidth: 1))
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
        
        VStack {
            if viewModel.isLoading {
                ProgressView("Carregando")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                let action = viewModel.validatingCredentials
                StandardButton(text: "Login", action: action)
                
            }
            if !viewModel.validationErrorText.isEmpty {
                Text(viewModel.validationErrorText)
            }
            if !viewModel.textError.isEmpty {
                Text(viewModel.textError)
            }
        }
        .onChange(of: viewModel.isLoggedIn ) {oldValue, newValue in
            if newValue {
                path.append("UsersView")
            }
        }
    }
}
