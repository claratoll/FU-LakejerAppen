import SwiftUI

struct ContactView: View {
    @State private var message: String = ""
    @Binding var isContactPresented : Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Kontakta oss")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            TextEditor(text: $message)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

            Button(action: {
                // Handle button action here
            }) {
                Text("Skicka medelande")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.007, green: 0.118, blue: 0.318, alpha: 1)), Color.orange]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)
        }
        .padding(.top, 20)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(isContactPresented: .constant(true))
    }
}
