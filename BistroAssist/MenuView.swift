import SwiftUI

struct FoodMenuView: View {
    var foodItems: [FoodMenuItem]
    var drinkItems: [FoodMenuItem]
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("Foods")) {
                    ForEach(foodItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                        }
                    }
                }

                Section(header: Text("Drinks")) {
                    ForEach(drinkItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                        }
                    }
                }

            
            }
            .navigationTitle("Menu")
        }
    }
}

struct FoodMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FoodMenuView(
            foodItems: [
                FoodMenuItem(name: "Pizza", price: 7.99),
                FoodMenuItem(name: "Burger", price: 5.99),
                // ... Add other food items here for the preview
            ],
            drinkItems: [
                FoodMenuItem(name: "Water", price: 1.99),
                FoodMenuItem(name: "Soda", price: 2.99),
               
            ]
        )
    }
}

