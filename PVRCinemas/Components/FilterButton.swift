import SwiftUI

struct FilterButton: View {
    let title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14))
            Toggle("", isOn: $isSelected)
                .labelsHidden()
        }
        .padding()
        .background(isSelected ? Color.yellow : Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}
