//
//  MemberSignUp.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-15.
//

import SwiftUI
import Firebase


struct UserSignUpView: View {
    @StateObject var viewModel = UserRegisterVM()
    var auth = Auth.auth()
    @State var name = ""
    @State var password = ""
    @State var memberNRText = ""
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
                            viewModel.register(email: email, password: password)
                            viewModel.saveMemberInfo(name: name, email: email, memberNr: memberNr)
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
                           .fullScreenCover(isPresented: $viewModel.isSignedUp) {
                               MenuView(signedIn: $viewModel.isSignedUp)
                                       }
                       }
                }
            }
        }
    }
}

struct MemberSignUp_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView()
    }
}
