//
//  GridImageView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct GridImageView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    var image: UIImage
    var index: Int
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                songViewModel.selectedImage = index
                songViewModel.showingImages = true
            }
        }, label: {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: (UIScreen.main.bounds.width - 100) / CGFloat(AppConstants.kSongImageColumns), maxHeight: 300, alignment: .center)
            }
        })
    }
}

struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongView(songViewModel: SongViewModel.preview[0])
        }
    }
}
