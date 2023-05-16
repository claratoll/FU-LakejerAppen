//
//  AdminSignUp.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-15.
//

import SwiftUI

struct AdminSignUp: View {
    @StateObject var viewModel = AdminRegisterVM()
    
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
                        Text("Email")
                        TextField("Email", text: $viewModel.email)
                               .font(.headline)
                               .frame(width: 220, height: 42)
                               .foregroundColor(.white)
                               .background(.gray)
                               .cornerRadius(20)
                               .padding()
                               
                           
                        Text("Lösenord")
                        SecureField("Lösenor", text: $viewModel.password)
                 
                             .font(.headline)
                            .frame(width: 220, height: 42)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(20)
                            .padding()
                        Button{
                            viewModel.register()
                        }
                    label: {
                               Text("Sign up")
                           }
                           .frame(width: 120, height: 42)
                           .foregroundColor(.white)
                           .background(Color.gray)
                           .cornerRadius(20)
                           .padding()
                       }
                }
            }
        }
    }
}

struct AdminSignUp_Previews: PreviewProvider {
    static var previews: some View {
        AdminSignUp()
    }
}
