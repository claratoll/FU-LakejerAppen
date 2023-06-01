//
//  NewsImagePicker.swift
//  Lakerslakejer
//
//  Created by A on 2023-06-01.
//

import Foundation
import UIKit
import SwiftUI

struct NewsImagePicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let NewsImagePicker = UIImagePickerController()
        NewsImagePicker.sourceType = .photoLibrary
        
        return NewsImagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        
    }
    
    
}
