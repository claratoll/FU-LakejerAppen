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
           
//                    LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
//                        .frame(width: 500, height: 300)
//                        .cornerRadius(12)
//
                    Image("MedlemLakersLakejer 1")
                        .frame(width: 600, height: 350)
                        .cornerRadius(12)
                    
                    Text(String("Medlem"))
                        .position(x:170, y: 40)
                        .foregroundColor(.white)
                        .italic()
                    
                    
                    Text(String(cardVM.name))
                        .position(x:170, y: 290)
                        .foregroundColor(.white)
                        .italic()
                    
                    Text("Lakej # " + String(cardVM.memberNr))
                        .position(x:550, y: 290)
                        .foregroundColor(.white)
                        .italic()
                    
//                    Text(Date.now, format: .dateTime.year())
//                        .position(x:550, y: 40)
//                        .foregroundColor(.white)
//                        .italic()
                    Text("Giltigt t.o.m. 2023-04-30")
                        .position(x:550, y: 40)
                        .foregroundColor(.white)
                        .italic()
               
                    
                }
                else{
                   
//                    LinearGradient(gradient: Gradient(colors: [.ui.orange,.ui.blue]), startPoint: .topLeading, endPoint: .bottomLeading)
                    Image("MedlemLakersLakejer 2")
                        .frame(width: 350, height: 200)
                        .cornerRadius(12)
                    
                    Text(String("Medlem"))
                        .position(x:50, y: 15)
                        .foregroundColor(.white)
                        .italic()
                        .font(.caption)
                    
                    Text(String(cardVM.name))
                        .position(x:50, y: 170)
                        .foregroundColor(.white)
                        .italic()
                    
                    Text("Lakej # " + String(cardVM.memberNr))
                        .position(x:260, y: 170)
                        .foregroundColor(.white)
                        .italic()
           
                    
//                    Text(Date.now, format: .dateTime.year())
                    Text("Giltigt t.o.m. 2023-04-30")
                        .position(x:250, y: 15)
                        .foregroundColor(.white)
                        .italic()
                        .font(.caption)
                    
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
