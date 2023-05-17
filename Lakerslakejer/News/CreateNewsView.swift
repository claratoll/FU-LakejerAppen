//
//  CreateNewsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-16.
//

import SwiftUI

struct CreateNewsView: View {
    @State private var headline: String = ""
    @State private var newsText: String = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject var newsVM = NewsVM()
    
    var body: some View {
        VStack {
            
            TextField("Headline", text: $headline)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("News Text", text: $newsText, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(15, reservesSpace: true)
                .padding()
            
            Spacer()
            Button("Save") {
            //    let newNews = News(date: Date(), headLine: headline, newsText: newsText)
                //Sends the news to the VM
                newsVM.saveToFirebase(headline: headline, date: Date(), text: newsText)
                
                // Dismiss the current view
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .background(Color.ui.blue)
    }
    
    
}
/*

struct CreateNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewsView()
    }
}
*/
