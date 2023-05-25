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
                    Ellipse()
                        .frame(width: 400, height: 132)
                        .foregroundColor(.white)
                    .offset(x:0, y:64)
                    Image("Logoskrift")
                        .resizable()
                        .frame(width: 180,height: 31)
                        .offset(x:0, y:34)
                        .padding(.top, 10)
                    
               
                }
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(width: 420, height: 452)
                        .foregroundColor(.white)
                    VStack {
                        Text("Email")
                           TextField("  Email", text: $email)
                               .font(.headline)
                               .frame(width: 220, height: 42)
                               .foregroundColor(.white)
                               .background(.gray)
                               .cornerRadius(20)
                               .padding()
                               
                               
                           
                        Text("Lösenord")
                           SecureField("  Lösenord", text: $password)
                 
                             .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                        Button{
                            login()
                        }
                    label: {
                               Text("Login")
                           }
                           .frame(width: 120, height: 42)
                           .foregroundColor(.white)
                           .background(Color.gray)
                           .cornerRadius(20)
                           .padding()
                        
                        Button(action: {
                            showSignUpType = true
                        }, label: {
                            Text("Don't have an account? Sign up")
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
