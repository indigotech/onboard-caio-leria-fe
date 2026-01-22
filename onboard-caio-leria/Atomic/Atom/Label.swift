import SwiftUI

struct Label: View {
    var text: String
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 24, weight: .regular, design: .default))
            .foregroundStyle(Color.gray)
    }
}
