//
//  LoginView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-15.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var showSignUpType = false
    @Binding var signedIn : Bool
    @State var showAlert = false
    var auth = Auth.auth()
    
    var body: some View {
        ZStack{
            Image("klack2")
       
            VStack{
                Spacer()
                ZStack{
                    LottieView(loopMode: .playOnce, animationName: "goldconfetti").frame(width: 40,height: 40)
                        .scaleEffect(0.7)

                    Ellipse()
                        .frame(width: 400, height: 132)
                        .foregroundColor(.white)
                    .offset(x:0, y:64)
                    Image("Logoskrift")
                        .resizable()
                        .frame(width: 190,height: 31)
                        .offset(x:0, y:34)
                        .padding(.top, 10)
                    
               
                }
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(width: 420, height: 452)
                        .foregroundColor(.white)
                    VStack {
                        
                        Text("Email")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(-9)
                            .offset(x:-70, y:6)
                            .multilineTextAlignment(.leading)
                        TextField("  Email", text: $email)
                               .font(.headline)
                               .padding(10)
                               .frame(width: 220, height: 42)
                               .foregroundColor(.white)
                               .background(.gray)
                               .cornerRadius(15)
                               .multilineTextAlignment(.leading)
                               .padding()
                               
                               
                           
                        Text("Lösenord ")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(-1)
                            .offset(x:-50, y:2)
                        SecureField("  Lösenord", text: $password)
                 
                             .font(.headline)
                             .padding(10)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(15)
                            .multilineTextAlignment(.leading)
                        Button{
                            login()
                        }
                    label: {
                               Text("Logga in")
                           }
                           .frame(width: 220, height: 52)
                           .foregroundColor(.white)
                           .background(Color.orange)
                           .cornerRadius(15)
                           .padding(30)
                        
                        Button(action: {
                            showSignUpType = true
                        }, label: {
                            Text("Har du inget konto? Bli medlem här!")
                        })
                        .navigationBarTitle("Sign Up Type")
                                    .sheet(isPresented: $showSignUpType) {
                                        UserSignUpView(signedIn: $signedIn)
                                    }
                       }
                }
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Felaktig Login"), message: Text("Fel lösenord eller email"), dismissButton: .default(Text("OK")))
            }
        }
    }
    func login(){
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                showAlert = true
            } else {
                print("Login successful")
                signedIn = true
            }
        }
    }
        
    }
    


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(signedIn: .constant(false))
    }
}
