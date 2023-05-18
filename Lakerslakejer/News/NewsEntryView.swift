//
//  NewsEntryView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-17.
//

import SwiftUI


struct NewsEntryView: View {

    var newsEntry : News?


    @EnvironmentObject var newsPlaceholder : NewsVM

    @State var content : String = ""
    @State var headline : String = ""
    @State var text : String = ""
    @State var image: String = ""

    // vi kan få tag på den vartsomhelst i appen
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        VStack{

           
            
            VStack(alignment: .center, spacing: 5.0){
                Image(newsEntry?.image ?? "eventgruppen")
                    .frame(width: 500, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .padding(.top,-40)
            }
            TextEditor(text: $headline)
            
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            
            
            TextEditor(text: $text)
                
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .background(Rectangle()
                        .frame(minWidth: 220)
                        .foregroundColor(.white)
                        .cornerRadius(20) )
                    .padding(.bottom,5)
                    .padding(.trailing, 5)
                    .padding(.leading, 5)
                    .padding(.top, -80)
            
            TextEditor(text: $content)
                .font(.title3)
                .fontWeight(.light)
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
            content = newsEntry.content ?? "Content"
            headline = newsEntry.headLine ?? "Headline"
            text = newsEntry.newsText ?? "newstext"
            image = newsEntry.image ?? "image"

        }
    }

    // våran funktion för att spara info.
    private func saveNews() {

        // vi ska kolla om den är nil
        if let newsEntry = newsEntry {

            //newsPlaceholder.update(news: newsEntry, with: content )
            
            newsPlaceholder.saveToFirebase(headline: headline, date: Date(), text: text)
            
        }else{
            //ändra news - uppdatera news på firebase

            /*let newNews = News(content: content, headline: headline,text: text, image: image)
            newsPlaceholder.publishedNews.append(newNews)
*/
        }


    }


}

struct NewsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewsEntryView()
    }
}
