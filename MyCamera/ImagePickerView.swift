//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by 後閑諒一 on 2021/04/26.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    
    @Binding var isShowSheet: Bool
    @Binding var captureImage: UIImage?
    
    class Coordinator: NSObject,
                       UINavigationControllerDelegate,
                       // UIImagerPickerControllerの操作をdelegateで検知する
                       UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        init (_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // 撮影が終わったときに呼ばれるdelegateメソッド
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info:
                [UIImagePickerController.InfoKey : Any]) {
            
            // 撮影した写真をcaptureImageに保存
            if let originalImage =
                info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage {
                parent.captureImage = originalImage
            }
        }
        
        // キャンセルボタンを選択したときに呼ばれるdelegateメソッド
        func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController) {
            parent.isShowSheet = false
        }
        
    }
    
    // Coordinatorを生成。SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Viewを生成する時に実行
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        myImagePickerController.sourceType = .camera
        myImagePickerController.delegate = context.coordinator
        return myImagePickerController
    }
    
    // Viewが更新された時に実行
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {

    }
    
}
