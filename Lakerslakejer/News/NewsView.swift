//
//  NewsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-17.
//

import SwiftUI


struct NewsView: View {
    
    // här skapar vi listan för tableviewn

    @StateObject var newsVM = NewsVM()
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(){
                    // hämtar våran lista med namn med id .self.
                    ForEach(newsVM.news){ newsEntry in
                        
                        // vi får en tillbaka knapp också
                        NavigationLink(destination: NewsEntryView(newsEntry: newsEntry)){
                            RowView(newsEntry: newsEntry)
                        }
                    }
                }
                .navigationTitle("Nyheter från klubben")
                
                .navigationBarItems(trailing: NavigationLink(destination: CreateNewsView()){
                    Image(systemName: "plus.circle")
                    
                })
            }
            .onAppear(){
                newsVM.listenToFirebase()
            }
        }
    }
}
    
    
struct RowView: View {
    let newsEntry : News
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            Image(newsEntry.image ?? "eventgruppen")
                .resizable()
                .aspectRatio(contentMode: .fit)
            // Gör hörnen runda
                .cornerRadius(15)
            
            HStack{
            Text(newsEntry.headLine ?? "headline")
                .bold()
                .foregroundColor(Color.blue)
                
           
            }
            //   Text(newsEntry.headline.prefix(7))
            
            Spacer()
            VStack{
                Spacer()
                Text(newsEntry.newsText ?? "news text")
                    .bold()
                VStack{
                    Spacer()
                    Text(newsEntry.content ?? "content")
                    Spacer()
                }
            }
        }
        // den fixar övre halvans bakgrundfärg(bilden)
        .padding()
        .background(Rectangle()
            .foregroundColor(.white)
                    //hörnen blir runda på kortet
            .cornerRadius(15)
            .shadow(radius: 15))
        
        //den fixar under halvans
        .padding()
        
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsVM())
    }
}


