//
//  UserVM.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-24.
//

import Foundation
import Firebase


class UserVM : ObservableObject{
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @Published var isSignedUp = false
    
    
    func checkUserAuthorization(completion: @escaping (Bool) -> Void) {
       
        guard let currentUser = Auth.auth().currentUser else {
        
            completion(false)
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(currentUser.uid)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
             
                let data = document.data()
                let admin = data?["admin"] as? Bool ?? false
                completion(admin)
            } else {
              
                completion(false)
                print("Error fetching user document: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func registerUser(email: String, password: String, name: String, memberNr: Int){
        
        auth.createUser(withEmail: email, password: password){ result, error in
            
            if let error = error{
                print("error signing up \(error)")
                
            }else{
                print("sign up successfull")
                saveMemberInfo (name: name, email: email, memberNr: memberNr)
                self.isSignedUp = true
                
            }
        }
        
        
        func saveMemberInfo (name: String, email: String, memberNr: Int){
            guard let user = auth.currentUser else {return}
            
            let itemsRef = db.collection("users").document(user.uid)
            let myuser = User(name: name, email: email,  admin: false, memberNr: memberNr, coupons: 0)
            //If sats om den redan finnst!
            
            do{
                //            try itemsRef.addDocument(data: ["name": name, "email": email, "memberNr": memberNr, "coupons": 0, "admin": false])
                try itemsRef.setData(from: myuser)
                
            } catch{
                
                print("no safely safe")
            }
            
            
        }
        
    }
    
    func isValidInput(name: String, memberNr: String, email: String, password: String) -> Bool{
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            
            return false
        }
        else if memberNr.count != 4 || !memberNr.allSatisfy({ $0.isNumber }){
            
            return false
            
        }
        
        return true
    }
    
    
    
    
    
}
