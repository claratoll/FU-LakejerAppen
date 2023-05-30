//
//  CardView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-17.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var cardVM : CardViewModel
    
    
    var body: some View {
           ZStack {
               
               LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
               
               
               
               Text(String(cardVM.name))
                   .position(x:70, y: 30)
                   .foregroundColor(.white)
                       
               Text(String(cardVM.memberNr))
                   .position(x:250, y: 30)
                   .foregroundColor(.white)
                       
               Text(Date.now, format: .dateTime.year())
                   .position(x:70, y: 170)
                   .foregroundColor(.white)
                   
               
               
           }.onAppear(perform: cardVM.getDetails)
      .frame(width: 350, height: 200)
               .cornerRadius(12)
          
       }
   }

   /*struct CardView_Previews: PreviewProvider {
       static var previews: some View {
           CardView()
       }
    }*/
