//
//  SignUpType.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-15.
//

import SwiftUI

struct SignUpType: View {
    @State private var showMemberSignUp = false
    @State private var showAdminSignUp = false
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
                    
                      
                       
//                    Text("Lakers lakejer")
//                        .font(.largeTitle)
                      //  .offset(x:0, y:54)
                }
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(width: 420, height: 452)
                        .foregroundColor(.white)
                    VStack {
                        
                        Button{
                            showMemberSignUp = true
                        }
                    label: {
                               Text("Member")
                           }
                           .frame(width: 120, height: 42)
                           .foregroundColor(.white)
                           .background(Color.gray)
                           .cornerRadius(20)
                           .padding()
                           .navigationBarTitle("Member Sign up")
                                       .fullScreenCover(isPresented: $showMemberSignUp) {
                                           UserSignUpView()
                                       }
                        Button{
                            showAdminSignUp = true
                        }
                    label: {
                               Text("Admin")
                           }
                           .frame(width: 120, height: 42)
                           .foregroundColor(.white)
                           .background(Color.gray)
                           .cornerRadius(20)
                           .padding()
                           .navigationBarTitle("Admin Sign up")
                                       .fullScreenCover(isPresented: $showAdminSignUp) {
                                           AdminSignUp()
                                       }
                       }
                }
                
            }
        }
    }
}

struct SignUpType_Previews: PreviewProvider {
    static var previews: some View {
        SignUpType()
    }
}
