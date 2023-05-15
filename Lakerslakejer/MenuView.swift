//
//  MenuView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-15.
//

import SwiftUI

struct MenuView: View {
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
                            Label("Home", systemImage: "greetingcard.fill")
                        }
                    
                    LogoutView() .tabItem{
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                }
             
                
            
                
            }
                
        }
     
            
      
}
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
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
                    .frame(width: 220, height: 32)
                    .foregroundColor(.white)
                    .background(Color(red: 125/255, green: 136/255, blue: 151/255))
                    .cornerRadius(20)
                    .padding()
            }
            Button{
                
            }label: {
                Text("Klippkort")
                    .font(.headline)
                    .frame(width: 220, height: 32)
                    .foregroundColor(.white)
                    .background(Color(red: 125/255, green: 136/255, blue: 151/255))
                    .cornerRadius(20)
                    .padding()
            }
            Button{
                
            }label: {
                Text("Nyheter")
                    .font(.headline)
                    .frame(width: 220, height: 32)
                    .foregroundColor(.white)
                    .background(Color(red: 125/255, green: 136/255, blue: 151/255))
                    .cornerRadius(20)
                    .padding()
            }
            Button{
                
            }label: {
                Text("Sponsra Tifogruppen")
                    .font(.headline)
                    .frame(width: 220, height: 32)
                    .foregroundColor(.white)
                    .background(Color(red: 125/255, green: 136/255, blue: 151/255))
                    .cornerRadius(20)
                    .padding()
            }
            Spacer()
        }
        
    }
}
