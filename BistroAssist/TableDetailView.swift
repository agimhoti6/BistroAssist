import SwiftUI

struct TableDetailView: View {
    var tableNumber: Int
    let icons: [Icon]
    @State private var selectedItemQuantities: [UUID: Int] = [:]

    let taxRate: Double = 0.08875 

    
    let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        VStack {
            
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(icons) { icon in
                        Button(action: {
                            // Increment the count for the selected item
                            self.selectedItemQuantities[icon.foodMenuItem.id, default: 0] += 1
                        }) {
                            Image(icon.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.bottom, 10)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .background(Color.lightRed)

            
            List {
                ForEach(getSortedMenuItems(), id: \.item.id) { (quantity, item) in
                    HStack {
                        Text("\(quantity)x \(item.name)")
                        Spacer()
                        Text("$\(Double(quantity) * item.price, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: removeItems)
            }

            
            VStack(alignment: .trailing) {
            
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        let subtotal = calculateSubtotal()
                        let tax = subtotal * taxRate
                        let total = subtotal + tax

                        Text("Subtotal: $\(subtotal, specifier: "%.2f")")
                        Text("Tax: $\(tax, specifier: "%.2f")")
                        Text("Total: $\(total, specifier: "%.2f")")
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
            }
        }
        .navigationBarTitle("Table \(tableNumber)", displayMode: .inline)
    }

    
    private func getSortedMenuItems() -> [(quantity: Int, item: FoodMenuItem)] {
        return selectedItemQuantities.compactMap { (key, value) -> (Int, FoodMenuItem)? in
            guard let item = icons.first(where: { $0.foodMenuItem.id == key })?.foodMenuItem else { return nil }
            return (value, item)
        }.sorted { $0.item.name < $1.item.name }
    }

    
    private func calculateSubtotal() -> Double {
        return selectedItemQuantities.reduce(0) { result, pair in
            if let item = icons.first(where: { $0.foodMenuItem.id == pair.key })?.foodMenuItem {
                return result + (Double(pair.value) * item.price)
            }
            return result
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let itemId = getSortedMenuItems()[index].item.id
            selectedItemQuantities[itemId] = nil
        }
    }

}


extension Color {
    static let lightRed = Color(red: 1.0, green: 0.8, blue: 0.8)
}

