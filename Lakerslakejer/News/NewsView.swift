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
        VStack{
            Image(newsEntry.image ?? "klack")
                .resizable()
            // Hela bilden kan nu visas i mobilen
                .aspectRatio(contentMode: .fit)
            // Gör hörnen runda
                .cornerRadius(15)
            Spacer()
            
            Text(newsEntry.headLine ?? "headline")
                .bold()
            Spacer()
            
            //   Text(newsEntry.headline.prefix(7))
            
            Spacer()
            VStack{
                Spacer()
                Text(newsEntry.newsText ?? "news text")
                VStack{
                    Spacer()
                    Text(newsEntry.content ?? "content")
                    Spacer()
                }
            }
        }
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsVM())
    }
}


