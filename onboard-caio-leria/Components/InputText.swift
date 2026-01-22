import SwiftUI

struct InputText: View {
    var title: String
    var placeholder: String
    @Binding var input: String
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            TextField(
                placeholder,
                text: $input
            )
            .border(Color.gray)
            .foregroundStyle(.black)
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
    }
}

