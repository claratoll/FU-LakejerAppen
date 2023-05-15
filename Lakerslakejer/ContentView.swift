//
//  ContentView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        
        VStack{
            Text("Hey")
                .foregroundColor(Color.ui.gold)
            Text("Julia är HÄR igen")
                .font(.headline)
                .foregroundColor(Color.ui.gray)

            //Alex var här
            //Mouhammads branch

        }
        .background(Color.ui.blue)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
