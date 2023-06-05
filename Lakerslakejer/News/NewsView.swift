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
import FirebaseStorage


struct NewsView: View {
    
    @State var isAdmin = false
    @Binding var newsIsPresented : Bool
    @State var selectedImage: UIImage?
    // här skapar vi listan för tableviewn

    @StateObject var newsVM = NewsVM()
    @ObservedObject var userVm = UserVM()
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
                    userVm.checkUserAuthorization { isAdmin in
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
                }.navigationTitle("Nyheter")
                .toolbar{
                        ToolbarItem(placement: .bottomBar) {
                                           Button(action: {
                                           newsIsPresented = false
                        
                                           }) {
                                               Image(systemName: "house.fill").foregroundColor(.ui.black)
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
    @State var retPictures = [UIImage]()
    
    var body: some View {
        ZStack{
           Color(.white)
            
            VStack(alignment: .leading, spacing: 5.0){
                
              ForEach(retPictures, id: \.self) { image in
                //Image(newsEntry.images ?? "eventgruppen")
                    Image(uiImage: image)
                        .frame(width: 310, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                    //   Spacer()
                    
               }
                
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
                                .fontWeight(.ultraLight)               .multilineTextAlignment(.leading)
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




struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(newsIsPresented: .constant(true)).environmentObject(NewsVM())
    }
}


