//
//  API.swift
//  MyWidgetExtension
//
//  Created by Jack Wong on 2021/02/24.
//

import Foundation

struct Response: Codable {
    var resultCount: Int
    var results:[Results]
}

struct Results: Codable {
    var artistName: String
    var country: String
    var collectionName: String
    var artworkUrl60: String
    var artworkUrl100: String
}

struct ResultList: Identifiable {
    var id: Int
    var artistName: String
    var country: String
    var collectionName: String
    var mediumImgUrl: String
    var largeImgUrl: String
}

enum APIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

protocol APIRespositoryService {
    func getData(completion: @escaping(Result<Response, APIError>) -> ())
}

class APIService: APIRespositoryService {
    
    static let shared = APIService()
    private let baseUrl = "https://itunes.apple.com/search?term=Best&limit=6"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    private init() {}
    
    func getData(completion: @escaping (Result<Response, APIError>) -> ()) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url, completion: completion)
    }
    
    private func executeDataTaskAndDecode<D: Decodable>(with url: URL, completion: @escaping (Result<D, APIError>) -> ()) {
        urlSession.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.executeInMainThread(result: .failure(.error(error as NSError)), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                self.executeInMainThread(result: .failure(.badHTTPResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeInMainThread(result: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let model = try self.jsonDecoder.decode(D.self, from: data)
                self.executeInMainThread(result: .success(model), completion: completion)
            } catch let error as NSError{
                print(error.localizedDescription)
                self.executeInMainThread(result: .failure(.invalidSerialization), completion: completion)
            }
        }.resume()
    }
    
    private func executeInMainThread<D: Decodable>(result: Result<D, APIError>, completion: @escaping (Result<D, APIError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
