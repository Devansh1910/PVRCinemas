import SwiftUI

struct OrderSnacksView: View {
    @State private var selectedVegOnly = false
    @State private var selectedNonVeg = false
    @State private var selectedBestsellers = false
    @State private var selectedPopular = false
    @State private var foodItems: [FoodItem] = loadJSON()
    @State private var cartItems: [CartItem] = []
    @State private var selectedItemID: String?
    @State private var selectedItem: FoodItem?
    @State private var selectedAddOns: [String: [String: Int]] = [:]

    var body: some View {
        VStack(spacing: 0) {
            headerView
            
            ScrollView {
                VStack(spacing: 16) {
                    sectionTitle("REPEAT AGAIN?")
                        .padding(.top, 10)
                        .background(Color.yellow.opacity(0.05))
                    
                    repeatAgainScrollView
                    
                    promotionalOffersScrollView
                    
                    sectionTitle("RECOMMENDED FOR YOU")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    recommendedForYouGrid
                    
                    filtersView
                    
                    menuItemsView
                    
                    sectionTitle("EXPLORE MORE")
                    normalVerticalScrollView
                }
                .padding(.bottom, 100)
            }
            cartSummaryView
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Order Snacks")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                HStack(spacing: 4) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text("PVR Plaza, New Delhi")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
    }
    
    private var repeatAgainScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(foodItems.filter { $0.Isrepeat }) { item in
                    MenuItemRow(
                        image: "🍿",
                        title: item.ItemName,
                        price: item.price,
                        isVeg: item.IsVeg,
                        quantity: Binding(
                            get: {
                                cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
                            },
                            set: { newValue in
                                updateCart(item: item, quantity: newValue)
                            }
                        ),
                        onAdd: {
                            addItemToCart(item)
                            selectedItem = item // Set the selected item
                        }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var promotionalOffersScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                PromoCard(
                    offerText: "Get 50% Off up to ₹140",
                    code: "Use PVRFOOD50"
                )
                PromoCard(
                    offerText: "Get 20% Off up to ₹100",
                    code: "Use PVRFOOD20"
                )
            }
            .padding(.horizontal)
        }
    }
    
    private var recommendedForYouGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(foodItems.filter { $0.Isrecommended }) { item in
                    MenuItemRow(
                        image: "🍿",
                        title: item.ItemName,
                        price: item.price,
                        isVeg: item.IsVeg,
                        quantity: Binding(
                            get: {
                                cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
                            },
                            set: { newValue in
                                updateCart(item: item, quantity: newValue)
                            }
                        ),
                        onAdd: {
                            addItemToCart(item)
                            selectedItem = item // Set the selected item
                        }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var filtersView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                FilterButton(title: "Veg", isSelected: $selectedVegOnly)
                FilterButton(title: "Non Veg", isSelected: $selectedNonVeg)
                FilterButton(title: "Bestsellers", isSelected: $selectedBestsellers)
                FilterButton(title: "Popular", isSelected: $selectedPopular)
            }
            .padding(.horizontal)
        }
    }
    
    private var menuItemsView: some View {
        VStack(spacing: 16) {
            ForEach(foodItems) { item in
                VStack(spacing: 0) {
                    // Menu Item Row
                    MenuItemRow(
                        image: "🍿",
                        title: item.ItemName,
                        price: item.price,
                        isVeg: item.IsVeg,
                        quantity: Binding(
                            get: {
                                cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
                            },
                            set: { newValue in
                                updateCart(item: item, quantity: newValue)
                            }
                        ),
                        onAdd: {
                            addItemToCart(item)
                            if let cartItem = cartItems.first(where: { $0.item.id == item.id }),
                               cartItem.quantity > 0 {
                                selectedItemID = item.id // Show add-ons
                            } else {
                                selectedItemID = nil // Hide add-ons
                            }
                        }
                    )
                    
                    // "PAIR THIS WITH" Section
                    pairWithSection(for: item)
                }
            }
        }
        .padding(.horizontal)
    }

    
    private func pairWithSection(for item: FoodItem) -> some View {
        Group {
            if selectedItemID == item.id,
               let cartItem = cartItems.first(where: { $0.item.id == item.id }),
               cartItem.quantity > 0,
               let addOns = item.AddOnItem,
               !addOns.isEmpty {
                subTitle("PAIR THIS WITH")
                pairWithScrollView(for: item)
            }
        }
    }


    
    private var filteredMenuItems: [FoodItem] {
        foodItems.filter { item in
            (!selectedVegOnly || item.IsVeg) &&
            (!selectedNonVeg || !item.IsVeg) &&
            (!selectedPopular || item.isPopularItem) &&
            (!selectedBestsellers || item.Isrecommended)
        }
    }
    
    private func addItemToCart(_ item: FoodItem) {
        if let existingIndex = cartItems.firstIndex(where: { $0.item.id == item.id }) {
            cartItems[existingIndex].quantity += 0
        } else {
            cartItems.append(CartItem(item: item, quantity: 1))
        }
    }

    private func removeItemFromCart(_ item: FoodItem) {
        if let existingIndex = cartItems.firstIndex(where: { $0.item.id == item.id }) {
            if cartItems[existingIndex].quantity > 1 {
                cartItems[existingIndex].quantity -= 0
            } else {
                cartItems.remove(at: existingIndex)
            }
        }
    }

    private func updateCart(item: FoodItem, quantity: Int) {
        if quantity == 0 {
            // Remove the parent item from the cart
            cartItems.removeAll { $0.item.id == item.id }
            
            // Remove all associated add-ons for the parent item
            if let addOns = selectedAddOns[item.id] {
                for addonId in addOns.keys {
                    cartItems.removeAll { $0.item.ItemID == addonId }
                }
                selectedAddOns[item.id] = nil
            }
        } else {
            if let index = cartItems.firstIndex(where: { $0.item.id == item.id }) {
                cartItems[index].quantity = quantity
            } else {
                cartItems.append(CartItem(item: item, quantity: quantity))
            }
        }
    }


    private var cartSummaryView: some View {
        VStack(spacing: 0) {
            if cartItems.isEmpty {
                HStack {
                    Image(systemName: "cart")
                    Text("No items added")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("₹\(calculateTotal(), specifier: "%.2f")")
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 2, y: -2)
            } else {
                VStack(spacing: 8) {
                    ForEach(cartItems) { cartItem in
                        HStack {
                            Text(cartItem.item.ItemName) // Use correct property name
                                .font(.headline)
                            Spacer()
                            Text("₹\(cartItem.item.price * Double(cartItem.quantity), specifier: "%.2f")")
                                .font(.headline)
                        }
                    }
                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text("₹\(calculateTotal(), specifier: "%.2f")")
                            .font(.headline)
                    }
                }
                .padding()
            }
            
            Button(action: {}) {
                Text("Proceed")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
            }
        }
    }

    private func calculateTotal() -> Double {
         cartItems.reduce(0) { $0 + ($1.item.price * Double($1.quantity)) }
     }
    
    private func pairWithScrollView(for item: FoodItem) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(item.AddOnItem ?? [], id: \.addonItemId) { addon in
                    AddOnItemRow(
                        addon: addon,
                        quantity: Binding(
                            get: {
                                selectedAddOns[item.id]?[addon.addonItemId ?? ""] ?? 0
                            },
                            set: { newQuantity in
                                updateAddOnQuantity(for: item, addon: addon, quantity: newQuantity)
                            }
                        )
                    )
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 8)
    }
    
    private func updateAddOnQuantity(for item: FoodItem, addon: AddOnItem, quantity: Int) {
        if selectedAddOns[item.id] == nil {
            selectedAddOns[item.id] = [:]
        }

        if quantity > 0 {
            selectedAddOns[item.id]?[addon.addonItemId ?? ""] = quantity
            updateCartWithAddOn(item: item, addon: addon, quantity: quantity)
        } else {
            selectedAddOns[item.id]?.removeValue(forKey: addon.addonItemId ?? "")
            if selectedAddOns[item.id]?.isEmpty ?? true {
                selectedAddOns[item.id] = nil
            }
            updateCartWithAddOn(item: item, addon: addon, quantity: 0)
        }
    }

    private func addAddOn(item: FoodItem, addon: AddOnItem) {
        if selectedAddOns[item.id] == nil {
            selectedAddOns[item.id] = [:] // Initialize an empty dictionary
        }

        // Increment the quantity of the add-on
        selectedAddOns[item.id]?[addon.addonItemId ?? ""] = (selectedAddOns[item.id]?[addon.addonItemId ?? ""] ?? 0) + 1

        // Update the cart
        updateCartWithAddOn(item: item, addon: addon, quantity: selectedAddOns[item.id]?[addon.addonItemId ?? ""] ?? 1)
    }

    private func removeAddOn(item: FoodItem, addon: AddOnItem) {
        if let currentQuantity = selectedAddOns[item.id]?[addon.addonItemId ?? ""] {
            if currentQuantity > 1 {
                // Decrease the quantity
                selectedAddOns[item.id]?[addon.addonItemId ?? ""] = currentQuantity - 1
            } else {
                // Remove the add-on entirely
                selectedAddOns[item.id]?.removeValue(forKey: addon.addonItemId ?? "")
            }

            // If no add-ons remain, clear the dictionary for this item
            if selectedAddOns[item.id]?.isEmpty ?? true {
                selectedAddOns[item.id] = nil
            }
        }

        updateCartWithAddOn(item: item, addon: addon, quantity: selectedAddOns[item.id]?[addon.addonItemId ?? ""] ?? 0)
    }


    private func updateCartWithAddOn(item: FoodItem, addon: AddOnItem, quantity: Int) {
        if let addonPrice = addon.price {
            cartItems.removeAll { $0.item.ItemID == addon.addonItemId }

            if quantity > 0 {
                cartItems.append(CartItem(item: FoodItem(
                    ItemID: addon.addonItemId ?? UUID().uuidString,
                    ItemName: addon.name ?? "Add-on",
                    IsVeg: item.IsVeg,
                    price: addonPrice,
                    isPopularItem: false,
                    foodType: item.foodType,
                    AddOnItem: nil,
                    Isrepeat: false,
                    Isrecommended: false
                ), quantity: quantity))
            }
        }
    }

    private var normalVerticalScrollView: some View {
        return VStack(alignment: .leading, spacing: 12) {
            ForEach(foodItems) { item in
                MenuItemRow(
                    image: "🍿",
                    title: item.ItemName,
                    price: item.price,
                    isVeg: item.IsVeg,
                    quantity: Binding(
                        get: {
                            cartItems.first(where: { $0.item.id == item.id })?.quantity ?? 0
                        },
                        set: { newValue in
                            updateCart(item: item, quantity: newValue)
                        }
                    ),
                    onAdd: { addItemToCart(item) }
                )
            }
        }
        .padding(.horizontal)
    }
    
    private func sectionTitle(_ title: String) -> some View {
        HStack(spacing: 8) {
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow.opacity(1), Color.yellow.opacity(0)]),
                startPoint: .trailing,
                endPoint: .leading
            )
            .frame(height: 1)
            .frame(maxWidth: .infinity)

            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
                .lineLimit(1)
                .truncationMode(.tail)
                .layoutPriority(2)

            LinearGradient(
                gradient: Gradient(colors: [Color.yellow.opacity(1), Color.yellow.opacity(0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    private func subTitle(_ title: String) -> some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
                .lineLimit(1)
                .truncationMode(.tail)
                .layoutPriority(2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct AddOnItemRow: View {
    let addon: AddOnItem
    @Binding var quantity: Int // Tracks quantity of the add-on

    var body: some View {
        HStack(spacing: 12) {
            // Left: Veg/Non-Veg Indicator
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: addon.addonItemId != nil ? "leaf.fill" : "circle.fill")
                    .foregroundColor(.green) // Add appropriate logic if needed
                    .font(.system(size: 14))
            }
            
            // Middle: Name and Price
            VStack(alignment: .leading, spacing: 4) {
                Text(addon.name ?? "Add-on")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("₹\(Int(addon.price ?? 0))")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Right: Quantity Controls
            if quantity > 0 {
                HStack(spacing: 12) {
                    Button(action: { quantity -= 1 }) {
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
                Button(action: { quantity = 1 }) {
                    Text("Add")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 16)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(6)
                }
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}



struct OrderSnacksView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSnacksView()
    }
}
