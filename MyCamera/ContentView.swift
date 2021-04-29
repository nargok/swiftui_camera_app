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
    @State var isShowActivity = false
    @State var isPhotolibrary = false
    @State var isShowAction = false
    
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
                isShowAction = true
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
                if isPhotolibrary {
                    PHPickerView(
                        isShowSheet: $isShowSheet, captureImage: $captureImage
                    )
                } else {
                    ImagePickerView(
                        isShowSheet: $isShowSheet,
                        captureImage: $captureImage)
                    
                }
                
            }
            .actionSheet(isPresented: $isShowAction) {
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
                            buttons: [
                                .default(Text("カメラ"), action: {
                                    isPhotolibrary = false
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        isShowSheet = true
                                    } else {
                                        print("カメラは利用できません")
                                    }
                                }),
                                .default(Text("フォトライブラリー"), action: {
                                    isPhotolibrary = true
                                    isShowSheet = true
                                }),
                                .cancel(),
                            ])
            }
            
            Button(action: {
                if let _ = captureImage {
                    isShowActivity = true
                }
            }) {
                Text("SNSに投稿する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            .sheet(isPresented: $isShowActivity) {
                ActivityView(shareItems: [captureImage!])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
