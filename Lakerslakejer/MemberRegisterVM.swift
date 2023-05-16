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

class MemberRegisterVM: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    let auth = Auth.auth()
    let db = Firestore.firestore()

    func register () {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                print("error signing up \(error)")
            }else{
                print("sign up successfull")
                guard let memberId = result?.user.uid else{return}
                self.uploadMemberInfo(id: memberId)
            }
        }
    }
    
    private func uploadMemberInfo(id: String) {
        let newMember = Member(id: id, name: name, email: email)
            
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
}

