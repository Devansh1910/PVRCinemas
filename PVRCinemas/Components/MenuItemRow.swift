import SwiftUI

struct MenuItemRow: View {
    let image: String
    let title: String
    let price: Double
    let isVeg: Bool
    @Binding var quantity: Int
    var onAdd: () -> Void
    var isCustomizable: Bool = false // Added option for customizable items

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            // Left - Image & Veg indicator
            ZStack(alignment: .topLeading) {
                Text(image)
                    .font(.system(size: 40))
                    .frame(width: 80, height: 80)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(8)
                
                Image(systemName: isVeg ? "leaf.fill" : "circle.fill")
                    .foregroundColor(isVeg ? .green : .red)
                    .font(.system(size: 12))
                    .offset(x: -4, y: -4)
            }
            
            // Middle - Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                
                Text("₹\(Int(price))")
                    .font(.system(size: 14, weight: .medium))
                
                if isCustomizable {
                    Text("Customizable")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Right - Add/Quantity
            if quantity > 0 {
                HStack(spacing: 12) {
                    Button(action: { if quantity > 0 { quantity -= 1 } }) {
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                            .background(Color.yellow)
                            .cornerRadius(4)
                    }
                    
                    Text("\(quantity)")
                        .font(.system(size: 16, weight: .medium))
                    
                    Button(action: { quantity += 1 }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .frame(width: 24, height: 24)
                            .background(Color.yellow)
                            .cornerRadius(4)
                    }
                }
            } else {
                Button(action: {
                    quantity = 1 // Set quantity to 1
                    onAdd()      // Trigger the `onAdd` closure
                }) {
                    Text("Add")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.yellow)
                        .cornerRadius(6)
                }
            }
        }
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
