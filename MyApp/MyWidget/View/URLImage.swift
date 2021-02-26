//
//  URLImage.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/26.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    private var placeholder: Image
    private var url: String
    
    init(url: String, placeholder: Image = Image(systemName: "placeholder")) {
        self.placeholder = placeholder
        //self.imageLoader.load(url: url)
        self.url = url
        
    }
    
    var body: some View {
        
        if let imgUrl = URL(string: url), let imgData = try? Data(contentsOf: imgUrl), let uiImg = UIImage(data: imgData) {
            Image(uiImage: uiImg)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        
    }
}
