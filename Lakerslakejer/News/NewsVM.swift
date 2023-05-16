//
//  NewsVM.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-16.
//


import Foundation
import Firebase
class NewsVM : ObservableObject {
    
    @Published var news = [NewsStruct]()
    
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    
    func saveToFirebase (headline: String, date: Date, text: String){
        //saves news to Firebase
        
      //  guard let user = auth.currentUser else {return}
        
        let newsRef = db.collection("news")
  //      let news = News(date: date, headLine: headline, newsText: text)
        
        let newsData: [String: Any] = [
                    "date": date,
                    "headLine": headline,
                    "newsText": text
                ]
                
        newsRef.addDocument(data: newsData) { error in
            if let error = error {
                print("Error saving to db: \(error)")
            } else {
                print("Added to Firebase")
            }
        }
        
    }
    
    
}



