//
//  MemberSignUp.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-15.
//

import SwiftUI
import Firebase


struct UserSignUpView: View {
    @ObservedObject var vm = UserVM()
    @Binding var signedIn : Bool
    var auth = Auth.auth()
    @State var name = ""
    @State var password = ""
    @State var memberNRText = ""
    @State var showAlert = false
    var memberNr : Int {
        return Int(memberNRText) ?? 0
    }
    @State var email = ""
    
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
                        TextField("Name", text: $name)
                            .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                        
                        TextField("Membership number", text: $memberNRText)
                        
                            .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                            .keyboardType(.numberPad)
                        
                        TextField("Email", text: $email)
                            .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                        
                        
                        SecureField("Lösenord", text: $password)
                        
                            .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                        Button{
                            if vm.isValidInput(name:name, memberNr: memberNRText, email: email, password: password){
                                vm.registerUser(email: email, password: password,name: name,
                                                memberNr: memberNr)
                            }
                            else {
                                showAlert = true
                            }
                        }
                    label: {
                        Text("Sign up")
                    }
                    .frame(width: 120, height: 42)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .padding()
                        
                    .navigationBarTitle("Sign Up Successful")
                    .fullScreenCover(isPresented: $vm.isSignedUp) {
                        MenuView(signedIn: $vm.isSignedUp)
                    }
                    }
                }
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Felaktiga uppgifter"), message: Text("Alla fält måste vara ifylld"), dismissButton: .default(Text("OK")))
                //kan också hanteras per fält som är fel men för nu gör vi så
                
            }
        }
    }
}
