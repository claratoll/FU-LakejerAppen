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
    @Published var bookedUser = [BookedUser]()
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
        print("fetchgames")
    }
    
    func fetchScannedMembers(gamesID : String) {
        db.collection("games").document(gamesID).collection("bookedUser").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                print("fetchgames")
                return
            }
            self.bookedUser = documents.compactMap { QueryDocumentSnapshot in
                try? QueryDocumentSnapshot.data(as: BookedUser.self)
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
    func saveMemberToFirebase(memberNr: Int, couponNumber: Int, gameID: String) {
      //  var game = "2YoJFhbZkCsEL6DOEFtt"
        
        let user = BookedUser(memberNumber: memberNr, couponNumber: couponNumber, scanned: true)
        
        let gameRef = db.collection("games").document(gameID).collection("bookedUser")
        
        do {
            try gameRef.addDocument(from: user)
        } catch {
            print("error saving to db")
        }
    }
    
}
