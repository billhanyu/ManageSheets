//
//  ImageView.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var songViewModel: SongViewModel
    @GestureState var draggingOffset: CGSize = .zero
    @GestureState var magnifyGestureState = CGFloat(1.0)
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            TabView(selection: $songViewModel.selectedImage) {
                ForEach(songViewModel.images.indices) {idx in
                    Image(uiImage: songViewModel.images[idx])
                        .resizable()
                        .scaleEffect(songViewModel.magnifyScale)
                        .aspectRatio(contentMode: .fit)
                        .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .gesture(DragGesture().updating($draggingOffset, body: {(value, outValue, _) in
            outValue = value.translation
        }).onEnded({value in
            print(value)
            withAnimation(.easeInOut) {
                songViewModel.showingImages = false
            }
        }))
        .gesture(TapGesture().onEnded({
            withAnimation(.easeInOut) {
                songViewModel.showingImages = false
            }
        }))
        .gesture(MagnificationGesture().updating($magnifyGestureState, body: { currentState, gestureState, transaction in
            gestureState = currentState
            songViewModel.onUpdateMagnify(value: magnifyGestureState)
        }).onEnded({ value in
            songViewModel.onEndMagnify(value: value)
        }))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
