//import SwiftUI
//
//struct MenuItemWithAddOns: View {
//    let item: FoodItem
//    @EnvironmentObject var cartManager: CartItemManager
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(item.name)
//                    .font(.headline)
//                Spacer()
//                Text("₹\(item.price, specifier: "%.2f")")
//            }
//
//            HStack {
//                Button(action: {
//                    let currentQuantity = cartManager.cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
//                    cartManager.updateCart(item: item, quantity: currentQuantity + 1)
//                }) {
//                    Text("+")
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(4)
//                }
//
//                Text("\(cartManager.cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0)")
//
//                Button(action: {
//                    let currentQuantity = cartManager.cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
//                    if currentQuantity > 0 {
//                        cartManager.updateCart(item: item, quantity: currentQuantity - 1)
//                    }
//                }) {
//                    Text("-")
//                        .padding()
//                        .background(Color.red)
//                        .foregroundColor(.white)
//                        .cornerRadius(4)
//                }
//            }
//
//            if let addOns = item.addOnItems, !addOns.isEmpty {
//                Text("Pair this with:")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                ForEach(addOns) { addOn in
//                    Text("\(addOn.name) - ₹\(addOn.price, specifier: "%.2f")")
//                        .font(.caption)
//                }
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(8)
//    }
//}
//
//
//
//private struct AddOnsSection: View {
//    let addOns: [AddOnItem]
//    @Binding var selectedAddOns: [String] // Binding to track selected add-ons by their IDs
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            Text("Add-Ons")
//                .font(.system(size: 14, weight: .semibold))
//                .padding(.horizontal)
//
//            ForEach(addOns) { addOn in
//                AddOnItemView(
//                    addOn: addOn,
//                    isSelected: Binding(
//                        get: {
//                            selectedAddOns.contains(addOn.id)
//                        },
//                        set: { isSelected in
//                            if isSelected {
//                                selectedAddOns.append(addOn.id)
//                            } else {
//                                selectedAddOns.removeAll { $0 == addOn.id }
//                            }
//                        }
//                    )
//                )
//            }
//        }
//        .padding(.horizontal)
//    }
//}
//
