import SwiftUI

struct UserDetailView: View {
    @Binding var path: NavigationPath
    @StateObject var userDetailViewModel = UserDetailViewModel()
    var userId: String
    var body: some View {
        VStack {
            HStack {
                Text("Name: ")
                    .frame(alignment: .leading)
                    .font(Font.title3.bold())
                Text(userDetailViewModel.user?.name ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font .caption)
            }
            HStack {
                Text("Email: ")
                    .frame(alignment: .leading)
                    .font(Font.title3.bold())
                Text(userDetailViewModel.user?.email ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font .caption)
            }
            HStack {
                Text("Data de nascimento: ")
                    .frame(alignment: .leading)
                    .font(Font.title3.bold())
                Text(userDetailViewModel.user?.birthDate ?? Date(), style: .date)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font .caption)
            }
            HStack {
                Text("Role: ")
                    .frame(alignment: .leading)
                    .font(Font.title3.bold())
                Text(userDetailViewModel.user?.role ?? "Desconhecido")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font .caption)
            }
        }
        .padding(.leading)
        .navigationTitle(Text("Detalhes do usuário"))
        .onAppear {
            userDetailViewModel.showDetails(id: userId)
        }
    }
}
