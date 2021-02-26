//
//  MyView.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/25.
//

import WidgetKit
import SwiftUI
import Combine

struct SmallRowView: View {
    var countryName: String
    var artistName: String
    var collectionName: String
    var body: some View {
        HStack(alignment: .bottom, spacing: 1){
            VStack(alignment: .leading, spacing: 2){
                
                Text(collectionName)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: .infinity, alignment: .leading)
                Text(countryName)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                    .frame(width: .infinity, height: .infinity, alignment: .leading)
                
            }
            VStack(alignment: .leading, spacing: 2){
                Text(artistName)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .frame(width: .infinity, height: .infinity, alignment: .trailing)
                Text("-4.36")
                    .lineLimit(1)
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                    .frame(width: .infinity, height: .infinity, alignment: .trailing)
            }
        }
    }
}

struct LongRowView: View {
    var countryName: String
    var artistName: String
    var collectionName: String
    var imgUrl: String
    let widgetWidth = Utils.longWidgetWidth()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 2){
                VStack(alignment: .leading, spacing: 2){
                    
                    Text(collectionName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: .none, height: .none, alignment: .leading)
                    Text(countryName)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                        .frame(width: .none, height: .none, alignment: .leading)
                    
                }.frame(maxWidth: widgetWidth * 2 / 3, alignment: .leading)
                URLImage(url: imgUrl, placeholder: Image("placeholder"))
                    .frame(maxWidth: widgetWidth/4, alignment: .center)
                VStack(alignment: .leading, spacing: 2){
                    Text(artistName)
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .frame(width: .none, height: .none, alignment: .trailing)
                    Text("-4.36")
                        .lineLimit(1)
                        .foregroundColor(.red)
                        .font(.system(size: 13))
                        .frame(width: .none, height: .none, alignment: .trailing)
                }.frame(maxWidth: widgetWidth/5, alignment: .leading)
            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 6, trailing: 10))
        }
    }
}

#if DEBUG
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: MyEntry(date: Date(), results: [ResultList(id: 0, artistName: "Jack Johnson", country: "USA", collectionName: "My First Data", mediumImgUrl: "MediumUrl", largeImgUrl: "LargeUrl")]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
#endif
