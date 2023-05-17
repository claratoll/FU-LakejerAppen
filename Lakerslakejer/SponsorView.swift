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
          Image("klack2")
               .resizable()
                .frame(width: 500, height: 350)
            VStack(spacing: 50) {
                Spacer()
                Text("Sponsra tifogruppen")
                Text("via Swish")
                
                Text("07xxxxxx")
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .center)
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
