//
//  EditView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var songViewModel: SongViewModel
    @State private var showPhotoLibrary = false
    @State private var image = UIImage()
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                TextField("Name", text: $songViewModel.name)
                TextField("Author", text: $songViewModel.author)
            }
            Section(header: Text("Images")) {
                ForEach(songViewModel.images.indices, id: \.self) { idx in
                    let image = songViewModel.images[idx]
                    Button(action: {
                        songViewModel.selectedImage = idx
                        songViewModel.showingImages = true
                    }, label: {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    })
                }
                .onDelete{indices in
                    // TODO
                }
                
                Button(action: {
                    image = UIImage()
                    showPhotoLibrary = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showPhotoLibrary, onDismiss: {
            if let _ = image.pngData() {
                songViewModel.images.append(image)
                image = UIImage()
            }
        }) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
        .fullScreenCover(isPresented: $songViewModel.showingImages, content: {
            ImageView().environmentObject(songViewModel)
        })
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditView(songViewModel: SongViewModel.preview[0])
        }
    }
}
