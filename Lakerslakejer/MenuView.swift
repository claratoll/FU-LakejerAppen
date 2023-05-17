//
//  MenuView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-15.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @State var showLogoutAlert = false
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    var body: some View {
        ZStack{

                
            VStack{
  //              ButtonView()
  
                
                
                
                TabView{
                    ButtonView()
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                            
                            
                        }
                    CouponView()
                        .tabItem{
                            Label("Klippkort", systemImage: "greetingcard.fill")
                        }
                    
                    Button (action: {showLogoutAlert = true})
                    {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                    .tabItem{
                        
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")}
                }
             
                
            
                
            }
        
                
        }.alert(isPresented: $showLogoutAlert)
        {
            Alert(
                          title: Text("Logga ut"),
                          message: Text("Vill du verkligen logga ut?"),
                          primaryButton: .cancel(),
                          secondaryButton: .destructive(Text("Logga ut"), action: performLogout)
                      )
            
            
            
            
        }
     
            
      
}
    private func performLogout(){
        do {
            try auth.signOut()
            signedIn = false
            
        } catch let error{
            
            print("Forever trapped")
        }


        
        }
}



    

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(signedIn: .constant(true))
    }
}

struct ButtonView: View {
    
    var body: some View {
    
            VStack{
                
                Button {}
            label:{
                //placeholder
                Image(systemName: "figure.hockey")
                    .frame(width: 420, height: 132)
                    .background(.orange)
            }
                //.padding(.bottom, 20)
                Spacer()
                Button{
                    
                }label: {
                    Text("Mitt Medlemskap")
                        .font(.headline)
                        .frame(width: 220, height: 42)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding()
                }
                Button{
                    
                }label: {
                    Text("Klippkort")
                        .font(.headline)
                        .frame(width: 220, height: 42)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding()
                }
                Button{
                    
                }label: {
                    Text("Nyheter")
                        .font(.headline)
                        .frame(width: 220, height: 42)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding()
                }
                Button{
                    
                }label: {
                    Text("Sponsra Tifogruppen")
                        .font(.headline)
                        .frame(width: 220, height: 42)
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(20)
                        .padding()
                }
                Spacer()
            }
            
        }
 
    
}
