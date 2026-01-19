import Foundation
import SwiftUI

struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()
    @State private var path = NavigationPath()
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.users, id: \.email) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title2)
                        Text(user.email)
                            .font(.caption)
                    }
                    .onAppear {
                        if user.id == self.viewModel.users.last?.id {
                            viewModel.fetchUsers()
                        }
                    }
                }
            }
            .navigationBarTitle("Usuários")
            .onAppear {
                viewModel.fetchUsers()
            }
            NavigationStack(path: $path){
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("+") {
                            path.append("SignUpView")
                        }
                        .font(.title)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding()
                        .navigationDestination(for: String.self) { value in
                            if value == "SignUpView" {
                                SignUpView()
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}
#Preview {
    UsersView()
}
