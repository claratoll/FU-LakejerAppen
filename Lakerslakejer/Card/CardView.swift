//
//  CardView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-17.
//

import SwiftUI

struct CardView: View {
    var body: some View {
           ZStack {
               LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
               
               
               
                   Text("Name")
                   .position(x:70, y: 30)
                       
                   Text("Card Number")
                   .position(x:250, y: 30)
                       
                   Text("Season")
                   .position(x:70, y: 170)
                   
               
               
           }.frame(width: 350, height: 200)
               .cornerRadius(12)
          
       }
   }

   struct CardView_Previews: PreviewProvider {
       static var previews: some View {
           CardView()
       }
   }
