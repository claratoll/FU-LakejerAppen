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
    
    /*
    func update(news: News, with  content: String){

        if let index = news.firstIndex(of: news){
        news[index].content = content

        }

    }*/

}

/*
 


    @Published var publishedNews = [News]()

     // en konstruktör som kör våran mockdata
     init(){
         addMockData()
     }

   
 }
 
 */



