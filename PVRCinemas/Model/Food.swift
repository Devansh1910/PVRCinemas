import Foundation

struct FoodItem: Identifiable, Codable {
    var id: String { ItemID } // This allows it to conform to Identifiable
    let ItemID: String
    let ItemName: String
    let IsVeg: Bool
    let price: Double
    let isPopularItem: Bool
    let foodType: String
    let AddOnItem: [AddOnItem]?
    let Isrepeat: Bool // Add this property
    let Isrecommended: Bool // Add this property

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
    }
}

struct AddOnItem: Codable, Identifiable {
    var id: String { addonItemId ?? UUID().uuidString } // Use addonItemId or fallback to a generated UUID
    let addonItemId: String?
    let name: String?
    let price: Double?
    let quantity: Int?
}


struct CartItem: Identifiable {
    var id = UUID() // A unique identifier
    let item: FoodItem
    var quantity: Int
}

