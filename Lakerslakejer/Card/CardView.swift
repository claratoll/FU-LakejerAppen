//
//  CardView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-17.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var cardVM : CardViewModel
    @State var sideWays : Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if geometry.size.width > geometry.size.height{
           
                    LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .frame(width: 500, height: 300)
                        .cornerRadius(12)
                  
                    Text(String(cardVM.name))
                        .position(x:170, y: 70)
                        .foregroundColor(.white)
                    
                    Text(String(cardVM.memberNr))
                        .position(x:550, y: 70)
                        .foregroundColor(.white)
                    
                    Text(Date.now, format: .dateTime.year())
                        .position(x:170, y: 290)
                        .foregroundColor(.white)
                    
                }
                else{
                   
                    LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topLeading, endPoint: .bottomLeading)
                        .frame(width: 350, height: 200)
                        .cornerRadius(12)
                  
                    
                    Text(String(cardVM.name))
                        .position(x:70, y: 30)
                        .foregroundColor(.white)
                    
                    Text(String(cardVM.memberNr))
                        .position(x:250, y: 30)
                        .foregroundColor(.white)
                    
                    Text(Date.now, format: .dateTime.year())
                        .position(x:70, y: 170)
                        .foregroundColor(.white)
                    
                }
            }
           }.onAppear(perform: cardVM.getDetails)
              
       }
   }

struct CardView_Previews: PreviewProvider {
       static var previews: some View {
           CardView(cardVM: CardViewModel()
           )
           .previewInterfaceOrientation(.landscapeLeft)
       }
    }
