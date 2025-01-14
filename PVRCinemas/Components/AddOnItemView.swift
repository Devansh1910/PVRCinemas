import SwiftUI

struct AddOnItemView: View {
    let addOn: AddOnItem
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Text(addOn.name ?? "Unknown") // Provide a fallback value for nil
                .font(.system(size: 14, weight: .medium))
            Spacer()
            Text("₹\(Int(addOn.price ?? 0))") // Provide a fallback value for nil
                .font(.system(size: 14, weight: .regular))
            Toggle("", isOn: $isSelected)
                .labelsHidden()
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
