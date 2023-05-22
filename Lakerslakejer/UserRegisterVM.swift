//
//  MemberRegisterVM.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation
import FirebaseAuth
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class UserRegisterVM: ObservableObject{
    @Published var name = ""
    @Published var memberNr : Int = 0
    @Published var email = ""
    @Published var password = ""
    @Published var isSignedUp = false
    @Published var coupons : Int = 0
    let auth = Auth.auth()
    let db = Firestore.firestore()
    //@Binding var signedIn : Bool
    
    @Environment(\.presentationMode) var presentationMode

    func register () {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("error signing up \(error)")
            }else{
                print("sign up successfull")
                guard let memberId = result?.user.uid else{return}
                self.uploadMemberInfo(id: memberId)
                self.isSignedUp = true
                
            }
        }
    }
    
    
    
    private func uploadMemberInfo(id: String) {
        let newMember = User(id: id, name: name, email: email, memberNr: memberNr)
            
            do {
                let db = Firestore.firestore()
                let data = try JSONEncoder().encode(newMember)
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    db.collection("Members").document(id).setData(dictionary)
                }
            } catch {
                print("Error encoding admin object: \(error)")
            }
        }
    
    func getCoupons (){
        guard let currenUser = Auth.auth().currentUser else {return}
       
        let userRef = db.collection("Members").document(currenUser.uid)
            
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    var user = try document.data(as: User.self)
                        
                        let coupons = user.coupons
                        self.coupons = coupons
                        
                     }catch {
                        print("Error decoding user document: \(error)")
                    }
            } else {
                print("User document does not exist")
            }
        }
    }
    
    func listenToFirestore(){
        // viktig så att det kan uppdateras när man tog bort en coupon
        // fast kankse inte - kan ju bara läsa ner för den som är inloggat
        // MEN kankse behöver admin sen en lista för att se nånting - låta den vara här just nu
        // och chatten
        
        db.collection("Members").addSnapshotListener() {
            //fick lägga till self här och förstår ej varför
            snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err{
                print("somethings really, really wrong")}
            else{
                self.members.removeAll()
                for document in snapshot.documents{
                    do{
                        
                        let member = try document.data(as : User.self)
                        self.members.append(member)
                    } catch {
                        print("nope")
                    }
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    //    func getCurrentUserDetails (){
    //
    //        guard let currentUser = Auth.auth().currentUser else {
    //
    //            return
    //        }
    //
    //        let userRef = db.collection("Members").document(currentUser.uid)
    //
    //         userRef.getDocument { (document, error) in
    //                if let document = document, document.exists {
    //                    do {
    //                        let user = try document.data(as: User.self)
    //                        if let user = user {
    //
    //                            print("User ID: \(user.id)")
    //                            print("User Name: \(user.name)")
    //                            print("User Email: \(user.email)")
    //
    //                        }
    //                    } catch {
    //                        print("Error decoding user document: \(error)")
    //                    }
    //                } else {
    //                    print("User document does not exist")
    //                }
    //            }
    //
    //
    //
    //
    //
    //    }
        
    
    
    
}

