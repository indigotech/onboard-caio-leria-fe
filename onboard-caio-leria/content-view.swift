import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        Text("Bem vindo(a) à Taqtile!")
            .font(.largeTitle).fontWeight(.bold)
        VStack {
            Text("Login")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
           TextField(
            "Login",
            text: $username
           )
           .border(Color.gray)
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
        VStack {
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            TextField(
                "Password",
                text: $password
            )
            .border(Color.gray)
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
        VStack {
            Button("Login") {
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(Color.blue)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
