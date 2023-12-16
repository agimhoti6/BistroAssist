import SwiftUI

@main
struct BistroAssistApp: App {
    @StateObject var rootViewModel = RootViewModel()
    @StateObject var restaurantManager = RestaurantManager()
    var body: some Scene {
        WindowGroup {
            if rootViewModel.userIsLoggedIn {
                ViewThree()
                    .environmentObject(rootViewModel)
                    .environmentObject(restaurantManager)
                    .id(rootViewModel.resetTrigger)
            } else {
                ContentView()
                    .environmentObject(rootViewModel)
                    .environmentObject(restaurantManager) 
                    .id(rootViewModel.resetTrigger)
            }
        }
    }
}

