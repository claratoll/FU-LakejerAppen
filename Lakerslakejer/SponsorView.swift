//
//  SponsorView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-17.
//

import SwiftUI

struct SponsorView: View {
    
    @Binding var isSwiftPresented : Bool
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Image("Logoskrift")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 300.0, height: 50.0)
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("Sponsra tifogruppen")
                        .font(.title)
                    Text("via Swish")
                        .font(.title)
                    
                    Text("1233200839")
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.title)
                    Spacer()
                    Spacer()
                    
                }   
            }

            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isSwiftPresented = false
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct SponsorView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorView(isSwiftPresented: .constant(true))
    }
}
//
