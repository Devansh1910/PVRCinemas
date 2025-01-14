import Foundation

struct FoodItem: Identifiable, Codable {
    var id: String { ItemID }
    let ItemID: String
    let ItemName: String
    let IsVeg: Bool
    let price: Double
    let isPopularItem: Bool
    let foodType: String
    let AddOnItem: [AddOnItem]?
    let Isrepeat: Bool
    let Isrecommended: Bool
    let imageName: String?

    enum CodingKeys: String, CodingKey {
        case ItemID
        case ItemName
        case IsVeg
        case price
        case isPopularItem
        case foodType
        case AddOnItem
        case Isrepeat
        case Isrecommended
        case imageName
    }
}

struct AddOnItem: Codable, Identifiable {
    var id: String { addonItemId ?? UUID().uuidString }
    let addonItemId: String?
    let name: String?
    let price: Double?
    let quantity: Int?
    let imageName: String?
}


//struct CartItem: Identifiable {
//    var id = UUID() // A unique identifier
//    let item: FoodItem
//    var quantity: Int
//}

