//
//  EditView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var song: Song
    @State private var showPhotoLibrary = false
    @State private var image = UIImage()
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                TextField("Name", text: Binding($song.name)!)
                TextField("Author", text: Binding($song.author)!)
            }
            Section(header: Text("Images")) {
                let arr = Array(song.images as? Set<SongImage> ?? [])
                ForEach(arr.indices, id: \.self) { idx in
                    let songImage = arr[idx]
                    Image(uiImage: UIImage(data: songImage.data!)!)
                           .resizable()
                           .frame(width: 80, height: 80)
                           .aspectRatio(contentMode: .fit)
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
            if let data = image.pngData() {
                let songImage = SongImage(context: viewContext)
                songImage.data = data
                song.addToImages(songImage)
                image = UIImage()
            }
        }) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        Text("TODO")
    }
}
