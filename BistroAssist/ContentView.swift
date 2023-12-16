import SwiftUI

struct ContentView: View {
    @EnvironmentObject var rootViewModel: RootViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.lightGray)
                
                VStack {
                    Text("BistroAssist")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    Image("restaurant")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                    
              
                    NavigationLink(destination: ViewTwo().environmentObject(rootViewModel)) {
                        Text("Enter")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 200, height: 60, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RootViewModel())
    }
}

