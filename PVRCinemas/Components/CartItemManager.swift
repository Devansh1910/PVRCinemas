//import SwiftUI
//
//class CartItemManager: ObservableObject {
//    @Published var cartItems: [CartItem] = []
//
//    func updateCart(item: FoodItem, quantity: Int) {
//        if quantity == 0 {
//            cartItems.removeAll { $0.item.id == item.id }
//        } else {
//            if let index = cartItems.firstIndex(where: { $0.item.id == item.id }) {
//                cartItems[index].quantity = quantity
//            } else {
//                cartItems.append(CartItem(item: item, quantity: quantity))
//            }
//        }
//    }
//
//    func getQuantity(for item: FoodItem) -> Int {
//        cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
//    }
//}
