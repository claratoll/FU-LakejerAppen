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
    @Published var games = [Game]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    
    func dataMatches(){
        let currentDate = Date()
        let game = Game(awayDate: currentDate, awayName: "FärjestadBK", firstBookDate: currentDate, lastBookDate: currentDate)
      let game2 = Game(awayDate: currentDate, awayName: "IK Oskarshamn", firstBookDate: currentDate, lastBookDate: currentDate)
      let game3 = Game(awayDate: currentDate, awayName: "Rögle BK", firstBookDate: currentDate, lastBookDate: currentDate)
      let game4 = Game(awayDate: currentDate, awayName: "HV71", firstBookDate: currentDate, lastBookDate: currentDate)
      let game5 = Game(awayDate: currentDate, awayName: "Linköping HC", firstBookDate: currentDate, lastBookDate: currentDate)
      let game6 = Game(awayDate: currentDate, awayName: "Leksands IF", firstBookDate: currentDate, lastBookDate: currentDate)
      let game7 = Game(awayDate: currentDate, awayName: "Malmö Redhawks", firstBookDate: currentDate, lastBookDate: currentDate)
      let game8 = Game(awayDate: currentDate, awayName: "Timrå IK", firstBookDate: currentDate, lastBookDate: currentDate)
     let game9 = Game(awayDate: currentDate, awayName: "Skellefteå AIK", firstBookDate: currentDate, lastBookDate: currentDate)
      let game10 = Game(awayDate: currentDate, awayName: "Frölunda HC", firstBookDate: currentDate, lastBookDate: currentDate)
     let game11 = Game(awayDate: currentDate, awayName: "MoDo Hockey", firstBookDate: currentDate, lastBookDate: currentDate)
      let game12 = Game(awayDate: currentDate, awayName: "Luleå Hockey", firstBookDate: currentDate, lastBookDate: currentDate)
      let game13 = Game(awayDate: currentDate, awayName: "Örebro Hockey", firstBookDate: currentDate, lastBookDate: currentDate)
       
        do {
           try  db.collection("games").addDocument(from: game)
          try  db.collection("games").addDocument(from: game11)
          try  db.collection("games").addDocument(from: game2)
          try  db.collection("games").addDocument(from: game3)
          try  db.collection("games").addDocument(from: game4)
          try  db.collection("games").addDocument(from: game5)
          try  db.collection("games").addDocument(from: game6)
          try  db.collection("games").addDocument(from: game7)
          try  db.collection("games").addDocument(from: game8)
          try  db.collection("games").addDocument(from: game9)
          try  db.collection("games").addDocument(from: game10)
          try  db.collection("games").addDocument(from: game12)
          try  db.collection("games").addDocument(from: game13)
      
            
        }
        catch {
            print ("nononokdkdkdk")
        }
        
        
//        var awayDate: Date
//        var awayName: String
//        var firstBookDate: Date
//        var lastBookDate: Date
    }
    
    func getDetails() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let userRef = db.collection("users").document(currentUser.uid)
        
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
        
        let userRef = db.collection("users").document(currentUser.uid)
        
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


