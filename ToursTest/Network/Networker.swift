//
//  Networker.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation

enum NetworkerError: Error {
    case unknown
    
}

enum Networker {
    static let snakeCaseDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static func fetchDepartCities(
        completion: @escaping ([DepartCity]?) -> Void
    ) {

        let endpoint = EndpointFactory.makeDepartCitiesEndpoint()
        
        guard let request = makeRequestFromEndpoint(endpoint: endpoint) else {
            completion(nil)
            return
        }

        send(request: request, with: SingleValueContainer<[DepartCitiesDTO]>.self) { response in
            completion(try? response.get().value.map{$0.toDomain()})
        }
    }
    
    static func searchTours(
        parameters: SearchRequest,
        completion: @escaping (Tour?) -> Void
    ) {

        let endpoint = EndpointFactory.makeSearchEndpoint(from: parameters)
        
        guard let request = makeRequestFromEndpoint(endpoint: endpoint) else {
            completion(nil)
            return
        }

        send(request: request, with: SingleValueContainer<ToursDTO>.self) { response in
            completion(try? response.get().value.toDomain())
        }
    }
    
    static func fetchCountries(
        completion: @escaping ([Country]?) -> Void
    ) {

        let endpoint = EndpointFactory.makeCountriesEndpoint()
        
        guard let request = makeRequestFromEndpoint(endpoint: endpoint) else {
            completion(nil)
            return
        }

        send(request: request, with: SingleValueContainer<[CountriesDTO]>.self) { response in
            completion(try? response.get().value.map{$0.toDomain()})
        }
    }
    
    static func getSearchResults(
        key: String,
        completion: @escaping (SearchResults?) -> Void
    ) {

        let endpoint = EndpointFactory.makeSearchGetInfoEndpoint(from: key)
        
        guard let request = makeRequestFromEndpoint(endpoint: endpoint) else {
            completion(nil)
            return
        }

        send(request: request, with: SingleValueContainer<SearchResultDTO>.self) { response in
            completion(try? response.get().value.toDomain())
        }
    }

    

    private static func send<ResponseType: Codable>(
        request: URLRequest,
        with type: ResponseType.Type,
        completion: @escaping (Result<ResponseType,Error>)->Void
    ) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(
                    "Произошла ошибка запроса:\n\"\(String(describing: request.url!))\"\n\(error)"
                )
            } else if let data = data {
                do {
                    print("⬅️ Код 200\nПолучен ответ на запрос \(request.url!)\nRaw data:\n\(String(data: data, encoding: .utf8) ?? String())")
                    let response = try snakeCaseDecoder.decode(ResponseType.self, from: data)
                    completion(.success(response))
                } catch(let error) {
                    completion(.failure(error))
                    print("Произошла ошибка при декодировании\n\(error)")
                }
                
            } else {
                completion(.failure(NetworkerError.unknown))
                print("Неопознанная ошибка")
            }
        }
        print("➡️ Отправлен запрос \(String(describing: request.url))")
        task.resume()
    }
 
    private static func makeRequestFromEndpoint(endpoint: EndpointRepresentable) -> URLRequest? {
        guard let url = URL(string: endpoint.url) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.type.rawValue
        request.httpBody = endpoint.body
        endpoint.headerParametes.forEach { parameter in
            request.addValue(parameter.value, forHTTPHeaderField: parameter.key.rawValue)
        }
        request.addValue("Token token=\(GlobalStorage.shared.apiKey)", forHTTPHeaderField:"Authorization")
        
        return request
    }
}

