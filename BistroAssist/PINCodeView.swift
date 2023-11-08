import SwiftUI

struct PinCodeView: View {
    @Binding var enteredPin: String

    var body: some View {
        ZStack{
            
            VStack(spacing: 10) {
                ForEach(0..<3) { row in
                    HStack(spacing: 10) {
                        ForEach(1..<4) { column in
                            let number = row * 3 + column
                            if number < 10 {
                                NumberButton(number: "\(number)", action: {
                                    self.enteredPin.append("\(number)")
                                })
                            } else if number == 10 {
                                ClearButton(action: {
                                    self.enteredPin = ""
                                })
                            }
                        }
                    }
                }
                
                HStack(spacing: 10) {
                    
                    ClearButton(action: {
                        self.enteredPin = ""
                    })
                    
                    NumberButton(number: "0", action: {
                        self.enteredPin.append("0")
                    })
                    .padding(.trailing, 92)
                }
                
                
            }
            
            
            .padding()
        }
    }
}


struct PinCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeView(enteredPin: .constant(""))
            .previewDisplayName("Pin Code View")
    }
}
