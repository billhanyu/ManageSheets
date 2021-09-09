//
//  SongView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct SongView: View {
    @ObservedObject var song: Song
    
    var body: some View {
        VStack{
            song.author.map(Text.init)
            List {
                ForEach(Array(song.images as? Set<SongImage> ?? [])) { songImage in
                    Image(uiImage: UIImage(data: songImage.data!)!)
                           .resizable()
                           .frame(width: 80, height: 80)
                           .aspectRatio(contentMode: .fit)
                        }
            }
        }
        .navigationTitle(song.name!)
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Text("TODO")
        }
    }
}
