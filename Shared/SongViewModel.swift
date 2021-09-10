//
//  SongViewModel.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

class SongViewModel: ObservableObject {
    @Published var name: String
    @Published var author: String
    @Published var images: [UIImage]
    @Published var showingImages = false
    @Published var selectedImage = 0
    
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
