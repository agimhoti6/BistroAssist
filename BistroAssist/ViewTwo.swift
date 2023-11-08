
import SwiftUI


struct ViewTwo: View {
    @State private var enteredPin: String = ""
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView { // Wrap the content in a NavigationView
            ZStack {
                Color(.lightGray)
                    .edgesIgnoringSafeArea(.all)
            
                VStack {
                    Text("Enter PIN:")
                        .font(.headline)
                        .padding(.bottom, 20)
                
                    // Use the PinCodeView here
                    PinCodeView(enteredPin: $enteredPin)
                
                    Button(action: {
                        if self.enteredPin == "1379" {
                            self.isActive = true
                        } else {
                            // Handle incorrect PIN
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                
                    NavigationLink(destination: ViewThree().navigationBarBackButtonHidden(true), isActive: $isActive) { // Here we hide the back button
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar on ViewTwo if desired
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use stack style to disable swipe to dismiss if needed
    }
}
