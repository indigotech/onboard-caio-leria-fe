import SwiftUI

struct StandardButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(10)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(Color.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.blue, lineWidth: 1))
        .padding(.horizontal)
        .font(.system(size: 24, weight: .regular, design: .default))
    }
}
