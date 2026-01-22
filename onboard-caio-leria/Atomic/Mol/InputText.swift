import SwiftUI

struct InputText: View {
    var title: String
    var placeholder: String
    @Binding var input: String
    var body: some View {
        VStack(spacing: 5) {
            Label(text: title)
            TextField(
                placeholder,
                text: $input
            )
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(.gray), lineWidth: 1))
        }
        .padding(.horizontal)
        .padding(.bottom, 2)
    }
}
