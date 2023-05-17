//
//  NewsView.swift
//  Lakerslakejer
//
//  Created by A on 2023-05-15.
//
import SwiftUI

struct NewsView: View {
    
    // här skapar vi listan för tableviewn
    @EnvironmentObject var news : NewsViewModel
    
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                List(){
                    // hämtar våran lista med namn med id .self.
                    ForEach(news.publishedNews){ newsEntry in
                        
                        // vi får en tillbaka knapp också
                        NavigationLink(destination: NewsEntryView(newsEntry: newsEntry)){
                            RowView(newsEntry: newsEntry)
                        }
                        
                    }
                    
                }
                // Ändra
                .navigationTitle("Nyheter från klubben")
                
                .navigationBarItems(trailing: NavigationLink(destination: NewsEntryView()){
                    
                    Image(systemName: "plus.circle")
                        //size
                })
            }
            
            
            
        }
    }
    
    
}
struct RowView: View {
    let newsEntry : News
    
    
    var body: some View {
        VStack{
            
            
            Image(newsEntry.image)
                .resizable()
            // Hela bilden kan nu visas i mobilen
                .aspectRatio(contentMode: .fit)
            // Gör hörnen runda
                .cornerRadius(15)
            Spacer()
            
            
            Text(newsEntry.headline)
                .bold()
            Spacer()
            
         //   Text(newsEntry.headline.prefix(7))
            
            Spacer()
            
            
            VStack{
                
                Spacer()
                
                Text(newsEntry.text)
                VStack{
                    Spacer()
                    
                    
                    Text(newsEntry.content)
                    
                    Spacer()
                    
                }
            }
            
        
        }
    }
    
    struct NewsView_Previews: PreviewProvider {
        static var previews: some View {
            NewsView().environmentObject(NewsViewModel())
        }
    }
    
   }
    
 

