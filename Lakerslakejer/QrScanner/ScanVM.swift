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
        //hämtar alla matcher i en lista
        
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
        //lägger alla scannade medlemmar i en lista
        
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
    
    
    func saveMemberToFirebase(memberNr: Int, couponNumber: Int, gameID: String, booked : Bool, scanned: Bool) {
        //sparar scannad medlem till lista
        
        print("1")
        
        let user = BookedUser(memberNumber: memberNr, couponNumber: couponNumber,booked: booked, scanned: scanned)
        
        let gameRef = db.collection("games").document(gameID).collection("bookedUser")
        
        gameRef.whereField("memberNumber", isEqualTo: memberNr).getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching user documents: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if documents.isEmpty {
                //user has not been booked or scanned
                
                print("2")
                
                do {
                    try gameRef.addDocument(from: user)
                    self.updateCouponsOnFirebase(memberNr: memberNr)
                } catch {
                    print("Error saving to db: \(error)")
                }
                
            } else {
                print("3")
                if let document = documents.first {
                    let documentID = document.documentID
                    if booked {
                        //user already booked
                        do {
                            try gameRef.document(documentID).setData(from: user, merge: true) { error in
                                if let error = error {
                                    print("Error updating document: \(error)")
                                } else {
                                    self.updateCouponsOnFirebase(memberNr: memberNr)
                                }
                            }
                        } catch {
                            print("Error updating document: \(error)")
                        }
                    } else {
                        print("User already scanned")
                    }
                }
            }
        }
    }
    
    
    func updateCouponsOnFirebase(memberNr: Int){
        //updaterar coupon - numret på firebase -1
        
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
                        user?.coupons -= 1
                        print("One coupon used")
                    } else {

                        print("No more coupons")
                    }
                    
                    if let user = user {
                        try document.reference.setData(from: user)
                    }
                } catch {
                    print("Error updating user document: \(error)")
                }
            } else {
                print("Member not found")
            }
        }
    }
    
}
