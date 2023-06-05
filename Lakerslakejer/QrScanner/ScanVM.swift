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
    
    
    func saveMemberToFirebase(memberNr: Int, couponNumber: Int, gameID: String, booked : Bool) {
        let user = BookedUser(memberNumber: memberNr, couponNumber: couponNumber,booked: booked, scanned: true)
        
        let gameRef = db.collection("games").document(gameID).collection("bookedUser")
        
        // Query to check if the user already exists
        gameRef.whereField("memberNumber", isEqualTo: memberNr).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching user documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if documents.isEmpty {
                // User does not exist, save the member to Firebase
                do {
                    try gameRef.addDocument(from: user)
                    self.updateCouponsOnFirebase(memberNr: memberNr)
                } catch {
                    print("Error saving to db: \(error)")
                }
            } else {
                // User already exists, handle accordingly (e.g., show an alert)
                print("User already scanned")
            }
        }
    }
    
    
    func updateCouponsOnFirebase(memberNr: Int){
        let userRef = db.collection("users")
        
        userRef.whereField("memberNr", isEqualTo: memberNr).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching user documents")
                return
            }
            
            
            if let document = documents.first {
                do {
                    var user: User? = try document.data(as: User.self)
                    if let coupons = user?.coupons, coupons > 0 {
                        // Coupons are greater than 0, decrement the value by 1
                        user?.coupons -= 1
                        print("One coupon used")
                    } else {
                        // Coupons are 0, handle accordingly (e.g., show "no more coupons" message)
                        print("No more coupons")
                    }
                    
                    if let user = user {
                        try document.reference.setData(from: user)
                    }
                } catch {
                    print("Error updating user document: \(error)")
                }
            } else {
                // Member not found, handle accordingly
                print("Member not found")
            }
        }
    }
    
}
