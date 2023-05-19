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
            
            print("Forever trapped \(error)")
        }
    }
}
    
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(signedIn: .constant(true))
    }
}

struct ButtonView: View {
    @State private var isCardViewVisible = true
    
    
    var body: some View {
        
        VStack{
            
            
            Button {}
        label:{
            //placeholder
           
            if isCardViewVisible {
                CardView()
                    .frame(width: 30, height: 200)
            }
                
        }
            
            //.padding(.bottom, 20)
            Spacer()
            NavigationView {
                VStack{
                    Spacer()
                    NavigationLink(destination: CouponView().onAppear { isCardViewVisible = false } .onDisappear { isCardViewVisible = true}) {
                        Text("Klippkort")
                            .frame(width: 200, height: 50)
                            .background(Color.ui.blue)
                            .foregroundColor(Color.ui.gray)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    NavigationLink(destination: NewsView().onAppear { isCardViewVisible = false } .onDisappear { isCardViewVisible = true}) {
                        Text("Nyheter")
                            .frame(width: 200, height: 50)
                            .background(Color.ui.blue)
                            .foregroundColor(Color.ui.gray)
                            .cornerRadius(10)
                    }
                    Spacer()
                    NavigationLink(destination: SponsorView().onAppear { isCardViewVisible = false } .onDisappear { isCardViewVisible = true}){
                        Text("Sponsra Tifogruppen")
                            .frame(width: 200, height: 50)
                            .background(Color.ui.blue)
                            .foregroundColor(Color.ui.gray)
                            .cornerRadius(10)
                    }
                    Spacer()
                    NavigationLink(destination: NewsView().onAppear { isCardViewVisible = false } .onDisappear { isCardViewVisible = true}){
                        Text("Kontakta styrelsen")
                            .frame(width: 200, height: 50)
                            .background(Color.ui.blue)
                            .foregroundColor(Color.ui.gray)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                
                
                
                
                Spacer()
            }
        }
    }
}
