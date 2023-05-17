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
        ZStack{
         //  Color(.systemBlue)
            //.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 5.0){
                Image(newsEntry.image ?? "eventgruppen")
                    .frame(width: 300, height: 200)
                   // .resizable()
                    .aspectRatio(contentMode: .fill)
                // Gör hörnen runda
                    .cornerRadius(10)
                   // .ignoresSafeArea()
                Spacer()
                
                    HStack{
                        
                        Text(newsEntry.headLine ?? "headline")
                        
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    
                    Spacer()
                    VStack{
                        Spacer()
                        Text(newsEntry.newsText ?? "news text")
                            .font(.title3)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                      
                        VStack{
                            Spacer()
                            Text(newsEntry.content ?? "Dagens datum eller mer text ")
                                .font(.title3)
                                .fontWeight(.ultraLight)               .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    
            
            
             
                
            }
            
            .padding(.top,10)
            .background(Rectangle()
                .frame(minWidth: 320)
                .foregroundColor(.white)
                        //hörnen blir runda på kortet
                .cornerRadius(10)
                .shadow(radius: 15))
            .padding(.bottom,5)
            .padding(.trailing, 5)
            .padding(.leading, 15)
            //den fixar under halvans
           // .padding()
        }
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsVM())
    }
}


