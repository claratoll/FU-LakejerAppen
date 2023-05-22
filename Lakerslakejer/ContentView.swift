//
//  ContentView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var signedIn = false
    
    var body: some View {
        
        ScannerView()
    /*
        if !signedIn{
            LoginView(signedIn: $signedIn)
        } else{
            MenuView(signedIn: $signedIn)
        }
        
        */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
