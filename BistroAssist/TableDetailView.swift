import SwiftUI

struct TableDetailView: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    var tableNumber: Int
    let icons: [Icon]
    @State private var selectedItemQuantities: [UUID: Int] = [:]

    let taxRate: Double = 0.08875
    @State private var isCheckoutViewPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(icons) { icon in
                            Button(action: {
                                selectedItemQuantities[icon.foodMenuItem.id, default: 0] += 1
                            }) {
                                Image(icon.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(.bottom, 10)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.red)

                List {
                    Section(header: Text("Selected Items")) {
                        ForEach(selectedItems, id: \.item.id) { (quantity, item) in
                            HStack {
                                Text("\(quantity)x \(item.name)")
                                Spacer()
                                Text("$\(Double(quantity) * item.price, specifier: "%.2f")")
                            }
                        }
                        .onDelete(perform: removeItems)
                    }

                    Section(header: Text("Processed Items")) {
                        ForEach(processedItems, id: \.item.id) { (quantity, item) in
                            HStack {
                                Text("\(quantity)x \(item.name)")
                                Spacer()
                                Text("$\(Double(quantity) * item.price, specifier: "%.2f")")
                            }
                        }
                    }
                }

                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            let subtotal = calculateTotal()
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

                Spacer()

                HStack {
                    Spacer()
                    Button("Send Order") {
                        sendSelectedItems()
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    Spacer()

                    Button("Checkout") {
                        isCheckoutViewPresented = true
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    Spacer()
                }

                NavigationLink(destination: CheckoutView(selectedItems: combinedItems, taxRate: taxRate), isActive: $isCheckoutViewPresented) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarTitle("Table \(tableNumber)", displayMode: .inline)
        }
    }

    private var selectedItems: [(quantity: Int, item: FoodMenuItem)] {
        selectedItemQuantities.compactMap { (key, value) -> (Int, FoodMenuItem)? in
            guard let item = icons.first(where: { $0.foodMenuItem.id == key })?.foodMenuItem else { return nil }
            return (value, item)
        }
        .sorted { $0.item.name < $1.item.name }
    }

    private var processedItems: [(quantity: Int, item: FoodMenuItem)] {
        restaurantManager.getProcessedOrders(forTable: tableNumber).compactMap { itemId, quantity -> (Int, FoodMenuItem)? in
            guard let item = icons.first(where: { $0.foodMenuItem.id == itemId })?.foodMenuItem else { return nil }
            return (quantity, item)
        }
    }

    private var combinedItems: [(quantity: Int, item: FoodMenuItem)] {
        selectedItems + processedItems
    }

    private func calculateTotal() -> Double {
        combinedItems.reduce(0) { result, pair in
            result + (Double(pair.quantity) * pair.item.price)
        }
    }

    private func sendSelectedItems() {
        restaurantManager.sendItems(forTable: tableNumber, itemQuantities: selectedItemQuantities)
        selectedItemQuantities.removeAll()
    }

    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let itemId = selectedItems[index].item.id
            selectedItemQuantities.removeValue(forKey: itemId)
        }
    }
}
