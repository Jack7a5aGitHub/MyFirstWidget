//
//  MyProvider.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/25.
//

import WidgetKit

struct MyProvider: TimelineProvider {
    func placeholder(in context: Context) -> MyEntry {
        MyEntry(date: Date(), results: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (MyEntry) -> ()) {
        getData(completion: completion)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MyEntry>) -> ()) {
        getData { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func getData(completion: @escaping (MyEntry) -> ()) {
        APIService.shared.getData { result in
            switch result {
            case .success(let response):
                var id = 0
                var resultList: [ResultList] = []
                response.results.prefix(6).forEach { item in  resultList.append(ResultList(id: id, artistName: item.artistName, country: item.country, collectionName: item.collectionName, mediumImgUrl: item.artworkUrl60, largeImgUrl: item.artworkUrl100))
                    id+=1
                }
                completion(.init(date: Date(), results: resultList))
            case .failure(let error):
                print(error)
                completion(.init(date: Date(), results: []))
            }
        }
    }
}
