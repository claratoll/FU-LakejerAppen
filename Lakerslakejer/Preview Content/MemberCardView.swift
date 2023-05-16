//
//  MemberCardView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-16.
//

import SwiftUI

struct MemberCardView: View {
    var body: some View {
           ZStack {
               LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
               
               
               
                   Text("Name")
                       .position(x:-30,y:160)
                       .rotationEffect(Angle(degrees: 90))
                   Text("Card Number")
                       .rotationEffect(Angle(degrees: 90))
                       .position(x: 313,y: 460)
                   Text("Season")
                   .position(x:-30,y:400)
                   .rotationEffect(Angle(degrees: 90))
               
               
           }.frame(width: 350, height: 600)
               .cornerRadius(12)
          
       }
   }

   struct MemberView_Previews: PreviewProvider {
       static var previews: some View {
           MemberCardView()
       }
   }

