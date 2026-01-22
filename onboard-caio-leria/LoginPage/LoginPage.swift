import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = .init()
    @StateObject private var usersViewModel: UsersViewModel = .init()
    @Binding var path: NavigationPath
    var body: some View {
        Text("Bem vindo(a) à Taqtile!")
            .font(.largeTitle).fontWeight(.bold)
        InputText(title: "Login",placeholder: "seuemail@email.com", input: $viewModel.email)
        VStack {
            Text("Senha")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            SecureField(
                "Senha",
                text: $viewModel.password
            )
            .border(Color.gray)
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
        
        VStack {
            if viewModel.isLoading {
                ProgressView("Carregando")
                    .progressViewStyle(CircularProgressViewStyle())
                
            } else {
                Button("Login") {
                    viewModel.validatingCredentials()
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .padding(.horizontal)
            }
        }
        .onChange(of: viewModel.isLoggedIn) { _, _ in
            path.append("UsersView")
        }
        if !viewModel.validationErrorText.isEmpty {
            Text(viewModel.validationErrorText)
        }
        if !viewModel.textError.isEmpty {
            Text(viewModel.textError)
        }
    }
}
