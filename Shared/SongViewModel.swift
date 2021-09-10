//
//  SongViewModel.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI
import CoreData

class SongViewModel: ObservableObject {
    @Published var name: String
    @Published var author: String
    @Published var images: [UIImage]
    @Published var showingImages = false
    @Published var selectedImage = 0
    
    init() {
        name = ""
        author = ""
        images = []
    }
    
    init(from song: Song) {
        name = song.name!
        author = song.author!
        images = Array(song.images as? Set<SongImage> ?? []).map({songImage in
            return UIImage(data: songImage.data!)!
        })
    }
    
    init(name: String, author: String, images: [String]) {
        self.name = name
        self.author = author
        self.images = images.map({name in
            UIImage(named: name)!
        })
    }
    
    func toSong(viewContext: NSManagedObjectContext) -> Song {
        let song = Song(context: viewContext)
        song.name = name
        song.author = author
        images.forEach({uiImage in
            let songImage = SongImage(context: viewContext)
            songImage.data = uiImage.pngData()
            song.addToImages(songImage)
        })
        return song
    }
}

extension SongViewModel: CustomStringConvertible {
    var description: String {
        return "\(name) by \(author) with \(images.count) images"
    }
}

extension SongViewModel {
    static var preview: [SongViewModel] {
        [
            SongViewModel(name: "song1", author: "author1", images: ["image1", "image2", "image3", "image4"]),
            SongViewModel(name: "song2", author: "author2", images: ["image1", "image2", "image3", "image4"]),
            SongViewModel(name: "song3", author: "author2", images: ["image1", "image2", "image3", "image4"])
        ]
    }
}
