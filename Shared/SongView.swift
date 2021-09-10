//
//  SongView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct SongView: View {
    @ObservedObject var songViewModel: SongViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(songViewModel.author)
                let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 3)
                LazyVGrid(columns: columns, alignment: .center, spacing: 10, content: {
                    ForEach(songViewModel.images.indices) { idx in
                        let songImage = songViewModel.images[idx]
                        GridImageView(image: songImage, index: idx).environmentObject(songViewModel)
                    }
                })
            }
            .padding()
        }
        .overlay(
            ZStack {
                if songViewModel.showingImages {
                    ImageView().environmentObject(songViewModel)
                }
            }
        )
        .navigationTitle(songViewModel.name)
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongView(songViewModel: SongViewModel.preview[0])
        }
    }
}
