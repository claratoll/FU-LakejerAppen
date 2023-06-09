
//
//  CreateNewsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-16.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct CreateNewsView: View {
    @State private var headline: String = ""
    @State private var newsText: String = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject var newsVM = NewsVM()
    @State var selectedImage: UIImage?
    @State var retPictures = [UIImage]()
    @State var picturePickerShow = false
    
    var body: some View {
        VStack {
            
            TextField("Headline", text: $headline)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("News Text", text: $newsText, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .lineLimit(15, reservesSpace: true)
                .padding()
            
            Button{
                picturePickerShow = true
            } label: {
                Text("Välj en bild här för din nyhet")
            }
            .frame(width: 360, height: 62)
            .foregroundColor(.white)
            .background(Color.orange)
            .cornerRadius(12)
            .padding(30)
            
            // Visas endast om du valt en bild, endast då kan du ladda upp bilden på storage
            
            if selectedImage != nil{
                Button{
                    uploadPhotoToFirebase()
                    
                } label: {
                    Text("Ladda upp bilden")
                }
                .frame(width: 360, height: 62)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(12)
                .padding(-10)
                
            }
            Spacer()
            
            Button("Spara din nyhet") {
                //Sends the news to the VM
                newsVM.saveToFirebase(headline: headline, date: Date(), text: newsText)
                
                // Dismiss the current view
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .sheet(isPresented: $picturePickerShow, onDismiss: nil){
                NewsImagePicker(selectedImage: $selectedImage, picturePickerShow: $picturePickerShow)
            }
            
        }
        .background(Color.ui.blue)
        
    }
    
    func uploadPhotoToFirebase() {
        
        let db = Firestore.firestore()
        
        // Kolla att bilden inte är nil
        guard selectedImage != nil else {
            return
        }
        
        // Reference till våran storage
        let storageRef = Storage.storage().reference()
        
        // Omvandla bild till data(storlek)
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        
        guard imageData != nil else {
            return
        }
        
        // Bildfilens plats och namn i firestore
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        
        // Ladda upp bilden
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                // Spara en referens i firestore
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url": path])
                
                DispatchQueue.main.async {
                
                    self.retPictures.append(self.selectedImage!)
                }
            }
        }
        
    }
    
    func getPhotosFromFirebase(){
        
        // Hämta datan från databasen
        let db = Firestore.firestore()
        
        // Hämta de specifika bildernas data
        db.collection("images").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                // Loopar igenom alla dokumenten
                for doc in snapshot!.documents {
                    
                    // Extrahera och lägg till i arrayen
                    paths.append(doc["url"] as! String)
                }
                
                // Hämta datan från storage
                for path in paths {
                    
                    let storageRef = Storage.storage().reference()
                    
                    // Rätt path
                    let fileRef = storageRef.child(path)
                    
                    // Här hämtar vi datan och väljer den storlek bilden ska vara
                    fileRef.getData(maxSize: 5 * 1024 * 1024){ data, error in
                        
                        if error == nil && data != nil {
                            
                            if let image = UIImage(data: data!) {
                                
                                
                                DispatchQueue.main.async {
                                    
                                    retPictures.append(image)
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
    }
    
}



struct CreateNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewsView()
    }
}
