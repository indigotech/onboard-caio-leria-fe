import Foundation
import SwiftUI

struct UsersView: View {
    @StateObject var viewModel = UsersViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        H1(text: "Usuários")
        ZStack {
            List(viewModel.users, id: \.id) { user in
                NavigationLink(value: "UserDetailView:\(user.id!)"){
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title2)
                        Text(user.email)
                            .font(.caption)
                    }
                }
                .onAppear {
                    if user.id == self.viewModel.users.last?.id {
                        viewModel.fetchUsers()
                    }
                }
            }
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
                }
            }
        }
        .onAppear {
            self.viewModel.fetchUsers()
        }
        
    }
}
