import Foundation
import SwiftUI

struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()
    var body: some View {
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
    }
}
