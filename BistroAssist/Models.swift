import Foundation

struct Icon: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    let foodMenuItem: FoodMenuItem
    
    init(name: String, imageName: String, foodMenuItem: FoodMenuItem) {
        self.id = UUID()
        self.name = name
        self.imageName = imageName
        self.foodMenuItem = foodMenuItem
    }
}

struct FoodMenuItem: Identifiable {
    let id: UUID
    let name: String
    let price: Double
    
    init(name: String, price: Double) {
        self.id = UUID()
        self.name = name
        self.price = price
    }
}

