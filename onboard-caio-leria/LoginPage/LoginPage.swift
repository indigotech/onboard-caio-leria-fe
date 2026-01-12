import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = LoginViewModel()
    var body: some View {
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
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            TextField(
                "Password",
                text: $viewModel.password
            )
            .border(Color.gray)
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
        VStack {
            Button("Login") {
               $viewModel.login()
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(Color.blue)
            .padding(.horizontal)
        }
    }
}
