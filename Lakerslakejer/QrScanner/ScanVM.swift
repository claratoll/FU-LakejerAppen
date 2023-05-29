//
//  ScanVM.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-25.
//

import Foundation
import Firebase


class ScanVM: ObservableObject {
    
    @Published var games = [Game]()
    let db = Firestore.firestore()

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
    
    
    func saveMemberToFirebase(name: String, memberNr: Int) {
        var game = "2YoJFhbZkCsEL6DOEFtt"
        
        let user = User(name: name, email: "hej@hej.se", memberNr: memberNr)
        
        let gameRef = db.collection("games").document(game).collection("bookedUser")
        
        do {
            try gameRef.addDocument(from: user)
        } catch {
            print("error saving to db")
        }
    }
    
}
