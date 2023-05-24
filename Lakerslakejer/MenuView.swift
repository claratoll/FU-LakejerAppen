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
    @ObservedObject var couponVM = CouponViewModel()
    @ObservedObject var cardVM = CardViewModel()
    @State var triggerCouponView = false
    @State private var selectedTab = 0
    @StateObject private var notificationManager = NotificationManager()
    
    var auth = Auth.auth()
    var body: some View {
        ZStack{
            
            
            VStack{
                //              ButtonView()
                
               
                
                
                TabView(selection: $selectedTab){
                    ButtonView(selectedTab: $selectedTab)
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                            
                            
                        }.tag(0)
                    CouponView(couponVM: couponVM )
                        .tabItem{
                            Label("Klippkort", systemImage: "greetingcard.fill")
                        }
                        .tag(1)
                    
                    Button (action: {showLogoutAlert = true})
                    {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                    .tabItem{
                        
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")}
                }.tag(2)
            }.onAppear(perform: notificationManager.reloadAuthorizationStatus)
                .onChange(of: notificationManager.authorizationStatus){
                    authorizationStatus in
                    
                    switch authorizationStatus{
                    case .notDetermined:
                        //fråga om lov
                        notificationManager.requestAuthorization()
                        
                    case .authorized :
                        notificationManager.reloadLocalNotificatins()
                        
                  
                    case .denied:
                         break
                        
                    default:
                        break
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
    @Binding var selectedTab: Int
    
    var body: some View {
        
        VStack{
            
            
            Button {}
        label:{
            //placeholder
           
            if isCardViewVisible {
                CardView(cardVM:CardViewModel())                    .frame(width: 30, height: 200)
            }
                
        }
            
            //.padding(.bottom, 20)
            Spacer()
            NavigationView {
                VStack{
                    Spacer()
                    
                    //if user = admin -- scannerview
                    //if user != admin -- couponview
                    
                    Button(action: {
                                    selectedTab = 1
                                }) {
                        Text("Klippkort")
                            .frame(width: 200, height: 50)
                            .background(Color.ui.blue)
                            .foregroundColor(Color.ui.gray)
                            .cornerRadius(10)
                    }
//                      NavigationLink(destination: CouponView(couponVM: CouponViewModel()).onAppear { isCardViewVisible = false } .onDisappear { isCardViewVisible = true}) {
//                        Text("Klippkort")
//                            .frame(width: 200, height: 50)
//                            .background(Color.ui.blue)
//                            .foregroundColor(Color.ui.gray)
//                            .cornerRadius(10)
//                    }
                    
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
