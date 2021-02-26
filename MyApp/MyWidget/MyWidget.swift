//
//  MyWidget.swift
//  MyWidget
//
//  Created by Jack Wong on 2021/02/24.
//

import WidgetKit
import SwiftUI

struct MyWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    var entry: MyProvider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            VStack {
                ForEach(entry.results.prefix(3), id:\.id){ item in
                    SmallRowView(countryName: item.country, artistName: item.artistName, collectionName: item.collectionName)
                }
            }
        case .systemMedium:
            VStack(alignment: .leading, spacing: 2){
                ForEach(entry.results.prefix(3), id:\.id){ item in
                    LongRowView(countryName: item.country, artistName: item.artistName, collectionName: item.collectionName, imgUrl: item.mediumImgUrl)
                    Divider().background(Color.yellow)
                }
            }
        case .systemLarge:
            VStack(alignment: .leading, spacing: 2){
                ForEach(entry.results, id:\.id){ item in
                    LongRowView(countryName: item.country, artistName: item.artistName, collectionName: item.collectionName, imgUrl: item.mediumImgUrl)
                    Divider().background(Color.yellow)
                }
            }
        default:
            Text("Some other WidgetFamily in the future.")
            
        }
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyProvider()) { entry in
            MyWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.9))
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: MyEntry(date: Date(), results: [ResultList(id: 0, artistName: "Jack Johnson", country: "USA", collectionName: "My First Data", mediumImgUrl: "MediumUrl", largeImgUrl: "LargeUrl")]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
