//
//  ActivityView.swift
//  MyCamera
//
//  Created by 後閑諒一 on 2021/04/29.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    let shareItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(
            activityItems: shareItems,
            applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
        // no process
    }
    
}
