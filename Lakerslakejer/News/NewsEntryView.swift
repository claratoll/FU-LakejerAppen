
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
    
    @State var isAdmin = false
    @State var content : String = ""
    @State var headline : String = ""
    @State var text : String = ""
    @State var images: String = ""

    // vi kan få tag på den vartsomhelst i appen
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 5.0){
                Image(newsEntry?.images ??  "images/\(UUID().uuidString).jpg")
                    .frame(width: 500, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .padding(.top,-40)
            }
            TextEditor(text: $headline)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            
            TextEditor(text:$text)
                
                    .font(.title3)
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
                    .background(Rectangle()
                        .frame(minWidth: 220)
                        .foregroundColor(.white)
                        .cornerRadius(20))
                    .padding(.bottom,5)
                    .padding(.trailing, 5)
                    .padding(.leading, 5)
                    .padding(.top, -80)
            
            // Här kan datum och skribent stå skrivet.
            TextEditor(text:$content)
                .font(.title3)
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.leading)
        }

        .onAppear(perform: setContent)
        .navigationBarItems(trailing: isAdmin ? Button("Spara nyhet"){
            saveNews()
            presentationMode.wrappedValue.dismiss()

        } : nil )

    }

    private func setContent(){

        // med if let så nil checkar vi entry
        if let newsEntry = newsEntry{
            content = newsEntry.content ?? "Content"
            headline = newsEntry.headLine ?? "Headline"
            text = newsEntry.newsText ?? "newstext"
            images = newsEntry.images ?? "images"

        }
    }

    // vår funktion för att spara info.
    private func saveNews() {

        // vi ska kolla om den är nil
        if let newsEntry = newsEntry {

            
            newsPlaceholder.saveToFirebase(headline: headline, date: Date(), text: text)
            
        }else{
            //ändra news - uppdatera news på firebase

            
        }
    }
}

struct NewsEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewsEntryView()
    }
}
