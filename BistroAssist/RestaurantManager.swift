import SwiftUI

class RestaurantManager: ObservableObject {
    @Published var tableOrders: [Int: [UUID: Int]] = [:] // Orders for each table
    @Published var sentItems: Set<UUID> = [] // IDs of items that have been sent to the kitchen/bar
    @Published var processedOrders: [Int: [UUID: Int]] = [:] // Quantities of processed orders for each table

    // Method to send items, considering the quantity of each item
    func sendItems(forTable tableNumber: Int, itemQuantities: [UUID: Int]) {
        for (id, quantity) in itemQuantities {
            processedOrders[tableNumber, default: [:]][id, default: 0] += quantity
            sentItems.insert(id)
        }
    }

    func isItemSent(itemId: UUID) -> Bool {
        sentItems.contains(itemId)
    }

    // Method to reset sent items for a new order or at the end of the day
    func resetSentItems() {
        sentItems.removeAll()
    }

    // Method to get the processed orders for a specific table
    func getProcessedOrders(forTable tableNumber: Int) -> [UUID: Int] {
        processedOrders[tableNumber] ?? [:]
    }
    
    // Method to clear the orders for a specific table after payment
    func clearOrders(forTable tableNumber: Int) {
        processedOrders[tableNumber] = [:]
    }
}
