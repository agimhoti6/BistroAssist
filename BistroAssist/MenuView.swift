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
                FoodMenuItem(name: "Hamburger", price: 5.99),
                FoodMenuItem(name: "Pasta", price: 8.99),
                FoodMenuItem(name: "Salad", price: 10.99),
                FoodMenuItem(name: "Steak", price: 8.99),
                FoodMenuItem(name: "Sushi", price: 10.99),
                
            ],
            drinkItems: [
                FoodMenuItem(name: "Water", price: 1.99),
                FoodMenuItem(name: "Beer", price: 2.99),
                FoodMenuItem(name: "Wine", price: 7.99),
                
            ]
        )
    }
}

