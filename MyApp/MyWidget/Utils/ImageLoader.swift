//
//  ImageLoader.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/26.
//

import Foundation
import SwiftUI
import Combine


//Widget not support to load imgage async, This class is meaningless
// 2 ways to solve
// 1, do it in Timeprovider
// 2,  fetches imgage synchronously
class ImageLoader: ObservableObject {
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func load(url:String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.didChange.send(nil)
                }
                return
            }
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }.resume()
    }
}
