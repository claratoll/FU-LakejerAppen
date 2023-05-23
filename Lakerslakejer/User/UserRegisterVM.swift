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
//    @Published var name = ""
//    @Published var memberNr : Int = 0
//    @Published var email = ""
//    @Published var password = ""
    @Published var isSignedUp = false
    @Published var coupons : Int = 0
    let auth = Auth.auth()
    let db = Firestore.firestore()
    //@Binding var signedIn : Bool
    @Published var members = [User]()
    
    @Environment(\.presentationMode) var presentationMode

    func register (email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("error signing up \(error)")
            }else{
                print("sign up successfull")
                guard let memberId = result?.user.uid else{return}
                //self.uploadMemberInfo(id: memberId)
                self.isSignedUp = true
                
            }
        }
    }
    
    
    func saveMemberInfo (name: String, email: String, memberNr: Int){
        guard let user = auth.currentUser else {return}
        
        let itemsRef = db.collection("users").document(user.uid).collection("UserData")
        let myuser = User(name: name, email: email,  admin: false, memberNr: memberNr, coupons: 0)
        //If sats om den redan finnst!
        
        do{
//            try itemsRef.addDocument(data: ["name": name, "email": email, "memberNr": memberNr, "coupons": 0, "admin": false])
            try itemsRef.addDocument(from: myuser)
            
        } catch{
            
            print("no safely safe")
        }
        
        
    }
    
    
    
//    private func uploadMemberInfo(id: String) {
//        let newMember = User( name: name, email: email, memberNr: memberNr)
//
//            do {
//                let db = Firestore.firestore()
//                let data = try JSONEncoder().encode(newMember)
//                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//
//                if let dictionary = dictionary {
//                    db.collection("Members").document(id).setData(dictionary)
//                }
//            } catch {
//                print("Error encoding admin object: \(error)")
//            }
//        }
//
//
//
        
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
        
    
    
    


