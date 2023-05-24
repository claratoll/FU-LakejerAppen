//
//  CardViewModel.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-23.
//

import Foundation
import Firebase


class CardViewModel: ObservableObject{
    @Published var name = ""
    @Published var memberNr : Int = 0
    @Published var members = [User]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    
    
    func getDetails() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let userRef = db.collection("Members").document(currentUser.uid)
        
        userRef.addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error)")
                return
            }
            
            do {
                var user = try document.data(as: User.self)
                
                let memberNr = user.memberNr
                let name = user.name
                
                self.memberNr = memberNr
                self.name = name
                
                print(String(memberNr))
                
            } catch {
                print("Error at: \(error)")
            }
        }
    }
    
    func getCurrentUserInfo() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userRef = db.collection("Members").document(currentUser.uid)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: User?.self)
                    if let user = user {
                        print("ID: \(user.id)")
                        print("Name: \(user.name)")
                        print("Email: \(user.email)")
                    }
                } catch {
                    print("Error at: \(error)")
                }
            } else {
                print("User does not exist")
            }
            
        }
    }
    
    
    
    
    
    
}


