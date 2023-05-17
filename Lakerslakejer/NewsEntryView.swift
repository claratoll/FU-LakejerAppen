//
//  NewsEntryView.swift
//  Lakerslakejer
//
//  Created by A on 2023-05-15.
//

import SwiftUI

struct NewsEntryView: View {
    
    var newsEntry : News?
    

    @EnvironmentObject var newsPlaceholder : NewsViewModel
    
    @State var content : String = ""
    @State var headline : String = ""
    @State var text : String = ""
    @State var image: String = ""
    
    // vi kan få tag på den vartsomhelst i appen
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            
            // som en edittext
            TextEditor(text: $content)
            TextEditor(text: $headline)
            TextEditor(text: $text)
        }
        
        .onAppear(perform: setContent)
        .navigationBarItems(trailing: Button("Lägg till"){
            saveNews()
            presentationMode.wrappedValue.dismiss()
            
        })
        
    }
    
    private func setContent(){
        
        // med if let så nil checkar vi entry
        if let newsEntry = newsEntry{
        content = newsEntry.content
            headline = newsEntry.headline
            text = newsEntry.text
            image = newsEntry.image
        
        }
    }
    
    // våran funktion för att spara info.
    private func saveNews() {
        
        // vi ska kolla om den är nil
        if let newsEntry = newsEntry {
            
            newsPlaceholder.update(news: newsEntry, with: content )
        }else{
            
            let newNews = News(content: content, headline: headline,text: text, image: image)
            newsPlaceholder.publishedNews.append(newNews)
            
        }
        
        
    }
    
    
}

struct NewsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewsEntryView()
    }
}
