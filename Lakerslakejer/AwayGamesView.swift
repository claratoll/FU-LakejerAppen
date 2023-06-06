//
//  AwayMatchesView.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct AwayGamesView: View {
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    /*struct ImageItem: Identifiable, Equatable {
        let id: String
        let imageName: String
    }*/
    
    //let images = ["FHC", "IKO", "LH", "HV71", "LHC", "LIF", "MALMO", "MODO", "OHK", "RBK", "SAIK", "TIK"].map { ImageItem(id: $0, imageName: $0) }
    @StateObject var scanVM = ScanVM()
    
    //@State private var selectedImage: ImageItem? = nil
    @Binding var awayIsPresented : Bool
    @State private var showAlert = false
    @State private var selectedGame: Game?
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(scanVM.games) { game in
                        Button(action: {
                            selectedGame = game
                            showAlert = true
                        }) {
                            HStack {
                                Text(game.awayName)
                                    .font(.title3)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .foregroundColor(.primary)
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(10)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Bokaresan"),
                                message: Text("Vill du boka den här bortaresa den \(scanVM.formattedDate(selectedGame?.awayDate ?? Date()))?"),
                                primaryButton: .cancel(),
                                secondaryButton: .default(Text("Book")) {
                                    bookGame()
                                }
                            )
                        }
                    }
                }
                .padding()
                
                /*ForEach(images) { imageItem in
                 ZStack {
                 Image(imageItem.imageName)
                 .resizable()
                 .scaledToFit()
                 .frame(height: 200)
                 .rotation3DEffect(.degrees(selectedImage == imageItem ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                 .onTapGesture {
                 withAnimation(.linear(duration: 0.5)) {
                 if selectedImage == imageItem {
                 selectedImage = nil
                 } else {
                 selectedImage = imageItem
                 }
                 }
                 }
                 
                 if selectedImage == imageItem {
                 Button(action: {
                 // book here function or view
                 }) {
                 Text("Boka här")
                 .padding()
                 .foregroundColor(.white)
                 .background(.blue)
                 .cornerRadius(10)
                 .font(.title2)
                 .bold()
                 }
                 .offset(y: 65) // Adjust the button position inside the image
                 }
                 }
                 }*/
            }
            .onAppear{
                scanVM.fetchGames()
            }
            .navigationBarTitle("Bortaresor")
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        awayIsPresented = false
                        
                    }) {
                        Image(systemName: "house.fill").foregroundColor(.ui.black)
                    }
                }
            }
        }
    }
    
    func bookGame() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userRef = db.collection("users").document(currentUser.uid)
        
        
        userRef.getDocument(completion: { (document, error) in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: User?.self)
                    if let user = user {
                        // Perform book match functionality
                        if let selectedGame = selectedGame {
                            scanVM.saveMemberToFirebase(memberNr: user.memberNr, couponNumber: user.coupons, gameID: selectedGame.id!, booked: true, scanned: false)
                            print("booked")
                        }
                    }
                } catch {
                    print("Error at: \(error)")
                }
            } else {
                print("User does not exist")
            }
        })
    }
}

struct AwayMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        AwayGamesView(awayIsPresented: .constant(true))
    }
}

