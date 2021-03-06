//
//  ImagePicker.swift
//  ManageSheets
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = fixOrientation(img: image)
            }
     
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        private func fixOrientation(img: UIImage) -> UIImage {
            if (img.imageOrientation == .up) {
                return img
            }

            UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
            let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
            img.draw(in: rect)

            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            return normalizedImage
        }
    }
}
