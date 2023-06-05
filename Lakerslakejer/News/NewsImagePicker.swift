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
    
    @Binding var selectedImage: UIImage?
    @Binding var picturePickerShow: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let NewsImagePicker = UIImagePickerController()
        NewsImagePicker.sourceType = .photoLibrary
        NewsImagePicker.delegate = context.coordinator
        
        return NewsImagePicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate,
                       UINavigationControllerDelegate{
        var parent: NewsImagePicker
        
        init(_ picker: NewsImagePicker){
            self.parent = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Koden körs när man valt en bild
            if let image = info[UIImagePickerController.InfoKey.originalImage] as?
                UIImage {
                
                DispatchQueue.main.async {
                    self.parent.selectedImage = image
                }
                
                
            }
            parent.picturePickerShow = false
            
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            // Koden körs när man avslutar picker UI
            parent.picturePickerShow = false
        }
    }
    
    
}
