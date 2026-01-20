import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(path: $path)
                .navigationDestination(for: String.self) { value in
                    if value == "UsersView" {
                        UsersView(path: $path)
                    } else if value == "SignUpView" {
                        SignUpView(path: $path)
                    }
                }
        }
    }
}

