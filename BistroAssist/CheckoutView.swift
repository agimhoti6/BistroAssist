import SwiftUI

enum PaymentMethod: String, CaseIterable {
    case cash = "Cash"
    case card = "Card"
}

enum GratuityOption: String, CaseIterable {
    case noGratuity = "No Gratuity"
    case fifteen = "15%"
    case eighteen = "18%"
    case twenty = "20%"
    case custom = "Custom"
}

struct CheckoutView: View {
    var selectedItems: [(quantity: Int, item: FoodMenuItem)]
    let taxRate: Double

    @State private var showingPaymentPopup = false
    @State private var paymentMethod: PaymentMethod = .cash
    @State private var selectedGratuityOption: GratuityOption = .noGratuity
    @State private var customGratuityInput: String = ""

    private var subtotal: Double {
        selectedItems.reduce(0) { total, nextItem in
            total + (Double(nextItem.quantity) * nextItem.item.price)
        }
    }

    private var taxAmount: Double {
        subtotal * taxRate
    }

    private var gratuityAmount: Double {
        switch selectedGratuityOption {
        case .noGratuity:
            return 0
        case .custom:
            return Double(customGratuityInput) ?? 0
        default:
            let percentage = Double(selectedGratuityOption.rawValue.filter("0123456789.".contains)) ?? 0
            return subtotal * (percentage / 100)
        }
    }

    private var total: Double {
        subtotal + taxAmount + gratuityAmount
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(selectedItems.indices, id: \.self) { index in
                        let quantity = selectedItems[index].quantity
                        let item = selectedItems[index].item
                        HStack {
                            Text("\(quantity)x \(item.name)")
                                .padding(.leading, 10)
                            Spacer()
                            Text("$\(Double(quantity) * item.price, specifier: "%.2f")")
                                .padding(.trailing, 10)
                        }
                        .background(Color.white)
                        .cornerRadius(5)
                    }
                }
                .padding(.vertical, 8)
            }

            VStack(alignment: .leading, spacing: 12) {
                Divider()
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text("$\(subtotal, specifier: "%.2f")")
                }

                HStack {
                    Text("Tax")
                    Spacer()
                    Text("$\(taxAmount, specifier: "%.2f")")
                }

                Picker("Gratuity", selection: $selectedGratuityOption) {
                    ForEach(GratuityOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                if selectedGratuityOption == .custom {
                    HStack {
                        Text("Custom Gratuity")
                        Spacer()
                        TextField("Amount", text: $customGratuityInput)
                            .keyboardType(.decimalPad)
                            .onChange(of: customGratuityInput) { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                if filtered != newValue {
                                    self.customGratuityInput = filtered
                                }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                HStack {
                    Text("Total")
                    Spacer()
                    Text("$\(total, specifier: "%.2f")")
                }
            }
            .padding([.leading, .trailing, .bottom])

            Button("Checkout") {
                showingPaymentPopup = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)

            Spacer()
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .padding(.top)
        .sheet(isPresented: $showingPaymentPopup) {
            PaymentPopupView(paymentMethod: $paymentMethod, total: total)
        }
    }
}

struct PaymentPopupView: View {
    @Binding var paymentMethod: PaymentMethod
    var total: Double
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Payment Method")) {
                    Picker("Payment Method", selection: $paymentMethod) {
                        Text(PaymentMethod.cash.rawValue).tag(PaymentMethod.cash)
                        Text(PaymentMethod.card.rawValue).tag(PaymentMethod.card)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("$\(total, specifier: "%.2f")")
                    }
                }

                Button("Pay") {
                    showingConfirmation = true
                }
                .alert(isPresented: $showingConfirmation) {
                    Alert(
                        title: Text("Payment Processed"),
                        message: Text("Payment has been processed successfully!"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .navigationTitle("Payment Options")
        }
    }
}

