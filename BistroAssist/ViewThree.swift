import SwiftUI

struct TableButton: View {
    let tableNumber: Int
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                
                Rectangle()
                    .foregroundColor(.brown)
                    .aspectRatio(1, contentMode: .fit)

                
                VStack {
                    HStack {
                        ChairView()
                        Spacer()
                        ChairView()
                    }
                    Spacer()
                    HStack {
                        ChairView()
                        Spacer()
                        ChairView()
                    }
                }
                .padding(8) 

               
                Text("Table \(tableNumber)")
                    .foregroundColor(.white)
                    .bold()
                    .font(.caption) // Smaller text
            }
        }
        .frame(width: 100, height: 100) // Set the frame for Button to contain the table and chairs
    }
}

struct ChairView: View {
    var body: some View {
        Circle()
            .frame(width: 15, height: 15) // Representation of a chair
            .foregroundColor(.blue)
    }
}


struct ViewThree: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var rootViewModel: RootViewModel
    let tables: [Int] = Array(1...10)
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var selectedTable: Int?
    @State private var showMenuView = false
    
    
    let icons: [Icon] = [
        Icon(name: "Pizza", imageName: "pizza", foodMenuItem: FoodMenuItem(name: "Pizza", price: 10.99)),
        Icon(name: "Hamburger", imageName: "hamburger", foodMenuItem: FoodMenuItem(name: "Hamburger", price: 8.99)),
        Icon(name: "Salad", imageName: "salad", foodMenuItem: FoodMenuItem(name: "Salad", price: 10.99)),
        Icon(name: "Pasta", imageName: "pasta", foodMenuItem: FoodMenuItem(name: "Pasta", price: 8.99)),
        Icon(name: "Sushi", imageName: "sushi", foodMenuItem: FoodMenuItem(name: "Sushi", price: 10.99)),
        Icon(name: "Steak", imageName: "steak", foodMenuItem: FoodMenuItem(name: "Steak", price: 8.99)),
        Icon(name: "Water", imageName: "water", foodMenuItem: FoodMenuItem(name: "water", price: 10.99)),
        Icon(name: "Beer", imageName: "beer", foodMenuItem: FoodMenuItem(name: "Beer", price: 10.99)),
        Icon(name: "Wine", imageName: "wine", foodMenuItem: FoodMenuItem(name: "wine", price: 10.99)),
        
        
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.lightGray).edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(tables, id: \.self) { table in
                                TableButton(tableNumber: table) {
                                    self.selectedTable = table
                                }
                                .frame(width: 80, height: 80)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button("Log Out") {
                            rootViewModel.userIsLoggedIn = false
                            rootViewModel.resetTrigger = UUID()
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        Spacer()
                        /*let foodNames: Set<String> = ["Pizza", "Hamburger", "Salad", "Pasta", "Sushi", "Steak"]
                         let drinkNames: Set<String> = ["Water", "Beer", "Wine"]
                         
                         let foodItems = icons.filter { foodNames.contains($0.name) }
                         .map { $0.foodMenuItem }
                         let drinkItems = icons.filter { drinkNames.contains($0.name) }
                         .map { $0.foodMenuItem }
                         */
                         Button("Menu") {
                         let foodNames: Set<String> = ["Pizza", "Hamburger", "Salad", "Pasta", "Sushi", "Steak"]
                         let drinkNames: Set<String> = ["Water", "Beer", "Wine"]
                         
                         let foodItems = icons.filter { foodNames.contains($0.name) }
                         .map { $0.foodMenuItem }
                         let drinkItems = icons.filter { drinkNames.contains($0.name) }
                         .map { $0.foodMenuItem }
                         
                         
                         print("Food items: \(foodItems)")
                         print("Drink items: \(drinkItems)")
                         
                         self.showMenuView = true
                         }
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.blue)
                         .cornerRadius(10)
                         Spacer()
                         
                         .navigationBarTitle("Floor Layout", displayMode: .inline)
                         .navigationBarHidden(true)
                         
                         
                         NavigationLink(destination: TableDetailView(tableNumber: selectedTable ?? 0, icons: icons), isActive: Binding(
                         get: { self.selectedTable != nil },
                         set: { _ in self.selectedTable = nil }
                         )) {
                         EmptyView()
                         }
                         .hidden()
                         
                         
                         }
                         .navigationBarBackButtonHidden(true)
                         .navigationBarHidden(true)
                         .interactiveDismissDisabled()
                         }
                         }
                         }
                         }
                         }
                    
struct ViewThree_Previews: PreviewProvider {
    static var previews: some View {
        ViewThree().environmentObject(RootViewModel())
    }
}



