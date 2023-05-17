//
//  News.swift
//  Lakerslakejer
//
//  Created by A on 2023-05-15.
//

import Foundation
struct News : Identifiable, Equatable{
    
    var id = UUID()
    
    var content : String
    var headline : String
    var text : String
    var image : String

    
    // när man skapar en ny nyhet och vi får automatiskt dagens datum
    private var unformattedDate = Date()
    
    private var dateFormatter = DateFormatter()
    
    // här skapar vi en konstruktör
    
    init(content: String, headline: String, text: String, image: String) {
        self.content = content
        self.headline = headline
        self.text = text
        self.image = image
        dateFormatter.dateStyle = .medium
    }
    
    var date : String {
        
        // här får vi vårat datum som är formatterad från det oformatterad datumet.
        return dateFormatter.string(from: unformattedDate)
        
    }
    
}
