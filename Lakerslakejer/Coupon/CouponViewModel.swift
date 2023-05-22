//
//  CouponViewModel.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-17.
//

import Foundation
import Firebase


class CouponViewModel: ObservableObject{
    @Published var name = ""
    @Published var memberNr : Int = 0
    @Published var email = ""
    @Published var coupons : Int = 0
    @Published var members = [User]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    //@Binding var signedIn : Bool
    

    
    func getCoupons() {
        guard let currentUser = Auth.auth().currentUser else { return }

        let userRef = db.collection("Members").document(currentUser.uid)

        userRef.addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            do {
                var user = try document.data(as: User.self)

                let coupons = user.coupons
                self.coupons = coupons
                let memberNr = user.memberNr
                self.memberNr = memberNr
                print(String(coupons))

            } catch {
                print("Error decoding user document: \(error)")
            }
        }
    }
    
    func listenToFirestore(){
        // viktig så att det kan uppdateras när man tog bort en coupon
        // fast kankse inte - kan ju bara läsa ner för den som är inloggat
        // MEN kankse behöver admin sen en lista för att se nånting - låta den vara här just nu
        // och chatten
        
        db.collection("Members").addSnapshotListener() {
        
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
    
func getCurrentUserDetails (){
    
            guard let currentUser = Auth.auth().currentUser else {
    
                return
            }
    
            let userRef = db.collection("Members").document(currentUser.uid)
    
             userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: User?.self)
                            if let user = user {
    
                                print("User ID: \(user.id)")
                                print("User Name: \(user.name)")
                                print("User Email: \(user.email)")
    
                            }
                        } catch {
                            print("Error decoding user document: \(error)")
                        }
                    } else {
                        print("User document does not exist")
                    }
                }
    
    
    
    
    
        }
        
    
    
    
}

