//
//  NewsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-17.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct NewsView: View {
    @State var isAdmin = false
    
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
                    .onDelete(){ indexSet in
                        for index in indexSet{
                            newsVM.deleteNewsFromUserList(index: index)
                        }
                    }
                }
               
                .navigationTitle("Nyheter från klubben")
                .onAppear {
                    checkUserAuthorization { isAdmin in
                        // Handle the value of isAdmin here
                        if isAdmin {
                            print("User is an admin")
                            DispatchQueue.main.async {
                                self.isAdmin = true
                            }
                        } else {
                            print("User is not an admin")
                            DispatchQueue.main.async {
                                self.isAdmin = false
                            }
                        }
                    }
                }

                
                .navigationBarItems(trailing: isAdmin ? NavigationLink(destination: CreateNewsView()) {
                    Image(systemName: "plus.circle")
                } : nil)


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
           Color(.white)
            
            VStack(alignment: .leading, spacing: 5.0){
                Image(newsEntry.image ?? "eventgruppen")
                    .frame(width: 310, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
             //   Spacer()
                
                    HStack{
                        
                        Text(newsEntry.headLine ?? "headline")
                        
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    
                   // Spacer()
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
                .frame(minWidth: 330)
                .foregroundColor(.white)
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

func checkUserAuthorization(completion: @escaping (Bool) -> Void) {
   
    guard let currentUser = Auth.auth().currentUser else {
    
        completion(false)
        return
    }
    
    let db = Firestore.firestore()
    let userRef = db.collection("users").document(currentUser.uid)
    
    userRef.getDocument { document, error in
        if let document = document, document.exists {
         
            let data = document.data()
            let admin = data?["admin"] as? Bool ?? false
            completion(admin)
        } else {
          
            completion(false)
            print("Error fetching user document: \(error?.localizedDescription ?? "")")
        }
    }
}


struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView().environmentObject(NewsVM())
    }
}


