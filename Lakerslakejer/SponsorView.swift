//
//  SponsorView.swift
//  Lakerslakejer
//
//  Created by Johan Karlsson on 2023-05-17.
//

import SwiftUI

struct SponsorView: View {
    var body: some View {
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
                    
                Text("07xxxxxx")
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title)
                Spacer()
                Spacer()
                    
            }
                            
        }
        
    }
}

struct SponsorView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorView()
    }
}
