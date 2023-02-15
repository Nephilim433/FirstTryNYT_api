//
//  Services .swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import Foundation

class APIService {

    static let shared = APIService()

    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
        static let apiKey = "EfOf1ClG8jAZFSjAG2I7WmZQttTkXlTH"
    }

    enum NetworkError: Error {
        case badURL
        case noData
        case decodingError
    }
    let decoder : JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()


    public func fetchCategory(category:String ,completion: @escaping (Result<[BookCellModel], NetworkError>) -> Void) {

        guard let url = createURL(for: category) else {
            return completion(.failure(.badURL))
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            let response = try? self.decoder.decode(CategoryResponse.self, from: data)

            if let response = response, let books = response.results.books {

                var booksModels = [BookCellModel]()
                books.forEach { book in
                    self.downloadImage(from: book.bookImage) { data in
                        booksModels.append(BookCellModel(booksName: book.title, booksDescription: book.description, author: book.author, publisher: book.publisher, rank: book.rank, buyLink: book.buyLinks, image: data))
                        if booksModels.count == books.count {
                            completion(.success(booksModels))
                        }
                    }
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    private func getData(from url:URL, complition: @escaping(Data?,URLResponse?,Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }

    private func downloadImage(from str: String,complition:@escaping (Data)->Void) {
        guard let url = URL(string: str) else { return }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            complition(data)
        }
    }

    func fetchCategoryItems(completion: @escaping (Result<NamesResponse, NetworkError>) -> Void) {
        guard let url = createURL() else {
            return completion(.failure(.badURL))
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            let response = try? self.decoder.decode(NamesResponse.self, from: data)
            if let response = response {
                print("response response")
                completion(.success(response))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }


    func createURL(for category: String? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nytimes.com"

        if let category = category {
            urlComponents.path = "/svc/books/v3/lists/current/\(category).json"
        } else {
            urlComponents.path = "/svc/books/v3/lists/names.json"
        }

        let apiQueryItem = URLQueryItem(name: "api-key", value: Constants.apiKey)
        urlComponents.queryItems = [apiQueryItem]

        return urlComponents.url
    }
}




