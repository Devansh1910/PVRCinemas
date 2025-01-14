import SwiftUI

struct ItemCard: View {
    let image: String
    let title: String
    let price: Double
    let isVeg: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack(alignment: .topLeading) {
                Text(image) // Dynamic emoji or image placeholder
                    .font(.system(size: 40))
                    .frame(width: 80, height: 80)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Image(systemName: isVeg ? "leaf.fill" : "circle.fill")
                    .foregroundColor(isVeg ? .green : .red)
                    .font(.system(size: 12))
                    .padding(4)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .leading) // Aligns the text to the leading edge

                
                HStack(spacing: 4) {
                    Text("₹\(Int(price))")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                    
                    Text("•")
                        .foregroundColor(.gray.opacity(0.8))
                    
                    Text("Customizable")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Add Button
            Button(action: {}) {
                Text("Add")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 20)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.yellow.opacity(0.8), lineWidth: 1)
                    )
            }
        }
        .padding(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
