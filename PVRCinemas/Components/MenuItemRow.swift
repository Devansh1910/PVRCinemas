import SwiftUI

struct MenuItemRow: View {
    let image: String // Image or emoji for the item
    let title: String // Item title
    let price: Double // Item price
    let isVeg: Bool // Veg/Non-Veg indicator
    @Binding var quantity: Int // Quantity of the item
    var onAdd: () -> Void // Action to add the item
    var isCustomizable: Bool = true // Customizable flag

    var body: some View {
        HStack(spacing: 12) {
            // Left - Image and Veg/Non-Veg Indicator
            ZStack(alignment: .topLeading) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                    .clipped()

                Image(systemName: isVeg ? "leaf.fill" : "circle.fill")
                    .foregroundColor(isVeg ? .green : .red)
                    .font(.system(size: 12))
                    .padding(4)
                    .background(Color.white)
                    .clipShape(Circle())
                    .offset(x: -4, y: -4)
            }

            // Middle - Item Details
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: 150) // Optional: To strictly limit width

                HStack(spacing: 4) {
                    Text("₹\(Int(price))")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)

                    if isCustomizable {
                        Text("• Customizable")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
            }

            Spacer()

            // Right - Add or Quantity Selector
            if quantity > 0 {
                HStack(spacing: 8) {
                    Button(action: { if quantity > 0 { quantity -= 1 } }) {
                        Image(systemName: "minus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(4)
                    }

                    Text("\(quantity)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)

                    Button(action: { quantity += 1 }) {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(4)
                    }
                }
            } else {
                Button(action: {
                    quantity = 1
                    onAdd()
                }) {
                    Text("Add")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.yellow.opacity(0.9))
                        .cornerRadius(6)
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemRow(
            image: "popcorn", // Replace with your image asset name
            title: "Popcorn Large with Extra Butter",
            price: 460,
            isVeg: true,
            quantity: .constant(0),
            onAdd: {},
            isCustomizable: true
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
