//
//  NewsViewModel.swift
//  Lakerslakejer
//
//  Created by A on 2023-05-15.
//

import Foundation

class NewsViewModel : ObservableObject {
    
   @Published var publishedNews = [News]()
    
    // en konstruktör som kör våran mockdata
    init(){
        addMockData()
    }
    
    func addMockData(){
        
        publishedNews.append(News(content: "2023",headline: "Vi vann SM-Guld", text: "Växjö Lakers HC, är en ishockeyklubb från Växjö i Sverige, bildad år 1997 som konkursbo efter Växjö HC. A-laget debuterade i seriespel den 23 oktober 1997 i Division 4, och sju säsonger senare hade Växjö Lakers avancerat till Hockeyallsvenskan",image: "klack"))
        publishedNews.append(News(content: "2023",headline: "Köp säsongskort", text: "Inför säsongen 2014/15 värvades den då 22 år gamla backen till Växjö Lakers, redo att SHL-debutera. Hans debutsäsong i så väl klubben som SHL skulle sluta succéartat när han var med och vann sitt men även klubbens första SM-guld. Tre år senare var Eric även med och vann klubbens andra SM-guld 2018.",image: "klack2"))
        publishedNews.append(News(content: "2023",headline: "Nya spelare ", text: "Ännu en gång",image: "eventgruppen"))
        publishedNews.append(News(content: "2023",headline: "Rea på supporterprylar", text: "Ännu en gång",image: "klack2"))
    }
    
    func update(news: News, with  content: String){
         
        
        if let index = publishedNews.firstIndex(of: news){
        publishedNews[index].content = content
          
        }
        
        
    }
   
}
