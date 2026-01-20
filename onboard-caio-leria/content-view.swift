import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    let pathUserList: String = "UsersView"
    let pathSignUp: String = "SignUpView"
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .navigationDestination(for: String.self) { value in
                    if value == pathUserList {
                        UsersView(path: $path)
                    } else if value == pathSignUp {
                        SignUpView(path: $path)
                    }
                }
        }
    }
}
