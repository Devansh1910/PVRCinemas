import SwiftUI

struct PromoCard: View {
    let offerText: String
    let code: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "tag.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 16))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(offerText)
                    .font(.system(size: 14, weight: .semibold))
                Text(code)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 240)
        .background(Color.yellow.opacity(0.08))
        .cornerRadius(10)
    }
}
