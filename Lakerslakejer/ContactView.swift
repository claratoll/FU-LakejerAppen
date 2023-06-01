import SwiftUI
import MessageUI
import Firebase
import FirebaseFirestore

struct ContactView: View {
    @State private var message: String = ""
    @Binding var isContactPresented: Bool
    @State private var userName: String = ""
    @State private var senderEmail: String = ""
    @State private var isShowingMailView = false
    
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
                // Show the email composer
                isShowingMailView = true
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
            .sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: $isShowingMailView, messageBody: message, userName: userName, senderEmail: senderEmail)
            }
        }
        .padding(.top, 20)
        .onAppear {
                    fetchUserName()
                }
    }
    
    func fetchUserName() {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        db.collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }

            if let data = snapshot?.data(),
                       let name = data["name"] as? String,
                       let email = data["email"] as? String {
                        userName = name
                        senderEmail = email
                    }
        }
    }

    
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(isContactPresented: .constant(true))
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let messageBody: String
    let userName: String
    let senderEmail: String
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.setToRecipients(["clara.toll@gmail.com"])
        viewController.setSubject("Contact Message from \(userName)")
        viewController.setMessageBody(messageBody, isHTML: false)
        viewController.setPreferredSendingEmailAddress(senderEmail)
        viewController.mailComposeDelegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailView
        
        init(_ parent: MailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
        }
    }
}
