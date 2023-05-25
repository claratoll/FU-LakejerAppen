//
//  NewsVM.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-16.
//


import Foundation
import Firebase

class NewsVM : ObservableObject {
    
    @Published var news = [News]()
    
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
    
    func deleteNewsFromUserList(index: Int){
        
        guard let user = auth.currentUser else {return}
        
        
        let newsRef = db.collection("news")
        
        let newNews = news[index]
        
        if let id = newNews.id {
            newsRef.document(id).delete()
        }
        
        
    }
    
    /*
    func update(news: News, with  content: String){

        if let index = news.firstIndex(of: news){
        news[index].content = content

        }

    }*/

    func listenToFirebase(){
        let newsRef = db.collection("news")
        
        
        newsRef.addSnapshotListener(){ snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("error getting document \(err)")
            } else {
                self.news.removeAll()
                
                for document in snapshot.documents {
                    do {
                        let newNews = try document.data(as : News.self)
                        self.news.append(newNews)
                    } catch {
                        print("error reading from db")
                    }
                }
                
                
            }
            
            
        }
        
    }
    
    
    
}


