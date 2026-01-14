import Foundation
import SwiftUI

struct UsersView: View {
    private let user: [User] = [
        User(name: "name", email: "email"),
        User(name: "name", email: "email"),
        User(name: "name", email: "email"),
        User(name: "name", email: "email")
    ]
    
    var body: some View {
        NavigationView {
            List(user, id: \.email) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.title2)
                    Text(user.email)
                        .font(.caption)
                }
            }
        }
        .navigationBarTitle("Usuários")
    }
}


