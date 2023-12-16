import Foundation

class RootViewModel: ObservableObject {
    @Published var userIsLoggedIn = false
    @Published var resetTrigger = UUID() 
}
