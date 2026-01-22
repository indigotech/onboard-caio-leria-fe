import SwiftUI

struct H1: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 32, weight: .bold))
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
    }
}
