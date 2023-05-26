//
//  AwayMatchesView.swift
//  Lakerslakejer
//
//  Created by Mouhammad Azroun on 2023-05-25.
//

import SwiftUI

struct AwayMatchesView: View {
    struct ImageItem: Identifiable, Equatable {
        let id: String
        let imageName: String
    }
    
    let images = ["FHC", "IKO", "LH", "HV71", "LHC", "LIF", "MALMO", "MODO", "OHK", "RBK", "SAIK", "TIK"].map { ImageItem(id: $0, imageName: $0) }
    
    @State private var selectedImage: ImageItem? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(images) { imageItem in
                        ZStack {
                            Image(imageItem.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .rotation3DEffect(.degrees(selectedImage == imageItem ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        if selectedImage == imageItem {
                                            selectedImage = nil
                                        } else {
                                            selectedImage = imageItem
                                        }
                                    }
                                }
                            
                            if selectedImage == imageItem {
                                Button(action: {
                                    // book here function or view
                                }) {
                                    Text("Boka här")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(.blue)
                                        .cornerRadius(10)
                                        .font(.title2)
                                        .bold()
                                }
                                .offset(y: 65) // Adjust the button position inside the image
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Bortaresor")
        }
    }
}

struct AwayMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        AwayMatchesView()
    }
}

