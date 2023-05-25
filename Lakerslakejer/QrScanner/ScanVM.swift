//
//  ScanVM.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-25.
//

import Foundation
import Firebase


class ScanVM: ObservableObject {
    
    @Published var games: [Game] = []

    private var db = Firestore.firestore()

    func fetchGames() {
        db.collection("games").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                print("fetchgames")
                return
            }

            self.games = documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: Game.self)
            }
        }
    }
    
    
    func saveMemberToFirebase() {
        
        let user = User(name: "clara", email: "clara@clara.se", memberNr: 3452)
        
        let gameRef = db.collection("games").document()
    }
    
}
