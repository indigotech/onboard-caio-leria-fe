import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = .init()
    var body: some View {
        NavigationStack {
            Text("Bem vindo(a) à Taqtile!")
                .font(.largeTitle).fontWeight(.bold)
            VStack {
                Text("Login")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title2)
                TextField(
                    "seuemail@email.com",
                    text: $viewModel.email
                )
                .border(Color.gray)
                .foregroundStyle(.black)
            }
            .padding(.horizontal)
            .padding(.bottom, 2)
            
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
                
            }.navigationDestination(isPresented: $viewModel.isLoggedIn) {
                UsersView()}
            
            if !viewModel.validationErrorText.isEmpty {
                Text(viewModel.validationErrorText)
            }
            if !viewModel.textError.isEmpty {
                Text(viewModel.textError)
            }
        }
    }
}
