//
//  AdminRegisterVM.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-16.
//

import Foundation
import FirebaseAuth
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AdminRegisterVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    let auth = Auth.auth()

    
    func register () {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error{
                print("error signing up \(error)")
            }else{
                print("sign up successful")
                guard let adminId = result?.user.uid else{return}
                self?.uploadAdminInfo(id: adminId)
            }
        }
    }
    
    private func uploadAdminInfo(id: String) {
            let newAdmin = Admin(id: id, email: email)
            
            do {
                let db = Firestore.firestore()
                let data = try JSONEncoder().encode(newAdmin)
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                
                if let dictionary = dictionary {
                    db.collection("Admins").document(id).setData(dictionary)
                }
            } catch {
                print("Error encoding admin object: \(error)")
            }
        }
    }


