//
//  ContentView.swift
//  MyCamera
//
//  Created by 後閑諒一 on 2021/04/26.
//

import SwiftUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    
    var body: some View {
        
        VStack {
            Spacer()
            
            if let unwrapCaptureImage = captureImage {
                Image(uiImage: unwrapCaptureImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            Button(action: {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("you can use camera!")
                    isShowSheet = true
                } else {
                    print("you can not use camera...orz")
                }
            }) {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            .sheet(isPresented: $isShowSheet) {
                ImagePickerView(
                    isShowSheet: $isShowSheet,
                    captureImage: $captureImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
