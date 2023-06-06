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
    @ObservedObject var userVM = UserVM()
    @State var triggerCouponView = false
    @State private var selectedTab = 0
    @StateObject private var notificationManager = NotificationManager()
    @State var isAdmin = false
    @State var isButtonview = true
    
    var auth = Auth.auth()
    var body: some View {
        ZStack{
            VStack{
                TabView(selection: $selectedTab){
                    ButtonView(selectedTab: $selectedTab, cardVM: cardVM)
                    
                        .tabItem{
                            Label("Home", systemImage: "house.fill")
                        }.tag(0)
                   
                    
                    if !isAdmin{
                        CouponView(couponVM: couponVM )
                            .tabItem{
                                Label("Klippkort", systemImage: "greetingcard.fill")
                            }
                            .tag(1)
                    }
                    else{
                        ScannedView(scanVM: ScanVM())
                            .tabItem{
                                Label("Scanner", systemImage: "qrcode.viewfinder")
                            }
                            .tag(1)
                        
                    }
                    Button (action: {showLogoutAlert = true})
                    {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")
                    }
                    .tabItem{
                        
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.forward")}
                    .tag(2)
                }
              
              
            }
            .onAppear(perform: notificationManager.reloadAuthorizationStatus)
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
                    
                    
                }.onAppear{
                    
                    userVM.checkUserAuthorization { isAdmin in
                        
                        if isAdmin {
                            print("User is an admin")
                            DispatchQueue.main.async {
                                self.isAdmin = true
                            }
                        } else {
                            // print("User is not an admin")
                            DispatchQueue.main.async {
                                self.isAdmin = false}
                            
                        }
                    }
                }
        }
      
        .alert(isPresented: $showLogoutAlert)
        
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
    @ObservedObject var userVM = UserVM()
    @ObservedObject var cardVM : CardViewModel
    @State var isAdmin = false
    @State var isButtonview = true
    @State var newsIsPresented = false
    @State var awayIsPresented : Bool = false
    @State var isSwiftPresented = false
    @State var isContactPresented = false


    var body: some View {
        GeometryReader { geometry in
        VStack{
            if geometry.size.width > geometry.size.height{
              
                CardView(cardVM: cardVM)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else{
          
                CardView(cardVM: cardVM)
                    
                    .frame(width: 200, height: 200)
                    .padding()
                    .offset(x:-73, y:2)
           
                Spacer()
                NavigationView {
                    VStack{

                        Spacer()
                        
                        //if user = admin -- scannerview
                        //if user != admin -- couponview
                        
                        
                        if !isAdmin{
                            Button(action: {
                                selectedTab = 1
                                print("\(selectedTab)")
                            }) {
                                
                                Text("Klippkort")
                                    .frame(width: 200, height: 50)
                                    .background(Color.ui.blue)
                                    .foregroundColor(Color.ui.gray)
                                    .cornerRadius(10)
                            }
                            
                            
                            Spacer()}
                        else{
                            Button(action: {
                                selectedTab = 1
                                
                            }) {
                                Text("Scanna medlemmar")
                                    .frame(width: 200, height: 50)
                                    .background(Color.ui.blue)
                                    .foregroundColor(Color.ui.gray)
                                    .cornerRadius(10)
                            }
                            Spacer()
                            
                        }
                        
                        Button(action: {newsIsPresented = true
                            
                        }){
                            
                            
                            Text("Nyheter")
                                .frame(width: 200, height: 50)
                                .background(Color.ui.blue)
                                .foregroundColor(Color.ui.gray)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button(action: {awayIsPresented = true
                            
                        }){
                            Text("Boka bortaresor")
                                .frame(width: 200, height: 50)
                                .background(Color.ui.blue)
                                .foregroundColor(Color.ui.gray)
                                .cornerRadius(10)
                            
                        }
                        Spacer()
                        Button(action: { isSwiftPresented = true
                            
                        }){
                            
                            Text("Sponsra tifogruppen")
                                .frame(width: 200, height: 50)
                                .background(Color.ui.blue)
                                .foregroundColor(Color.ui.gray)
                                .cornerRadius(10)
                        }
                        Spacer()

                        Button(action: { isContactPresented = true
                        }){
                            
                            Text("Kontakta styrelsen")
                                .frame(width: 200, height: 50)
                                .background(Color.ui.blue)
                                .foregroundColor(Color.ui.gray)
                                .cornerRadius(10)
                        }
                    }.onAppear{
                        
                        userVM.checkUserAuthorization { isAdmin in
                            
                            if isAdmin {
                                print("User is an admin")
                                DispatchQueue.main.async {
                                    self.isAdmin = true
                                }
                            } else {
                                // print("User is not an admin")
                                DispatchQueue.main.async {
                                    self.isAdmin = false}
                                
                            }
                        }
                    }
                    Spacer()
                }
            }
            }
        }.fullScreenCover(isPresented: $awayIsPresented ){
            AwayGamesView(awayIsPresented: $awayIsPresented)
        }
        .fullScreenCover(isPresented: $isSwiftPresented){
            SponsorView(isSwiftPresented: $isSwiftPresented)
        }

        .fullScreenCover(isPresented: $newsIsPresented){
            NewsView(newsIsPresented: $newsIsPresented)
        }
        .fullScreenCover(isPresented: $isContactPresented){
            ContactView(isContactPresented: $isContactPresented)
        }
    }
}
