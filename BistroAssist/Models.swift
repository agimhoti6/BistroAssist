import Foundation

// Represents an item on the food menu, including its name and price.
struct FoodMenuItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

// Represents an icon that can be displayed in the UI alongside a menu item.
struct Icon: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let foodMenuItem: FoodMenuItem
}
