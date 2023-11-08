import SwiftUI

struct NumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct ClearButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Clear")
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct SubmitButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Submit")
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct ButtonsPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            
        }
        .padding()
    }
}

