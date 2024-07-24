//
//  Webservice.swift
//  RestRoomFinder (iOS)
//
//  Created by Ding Lo on 18/7/2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case noData
}

class Webservice {
    func getRestroomsByLatAndLng(lat: Double, lng: Double, completion: @escaping (Result<[Restroom]?, NetworkError>) -> Void) {
        print(Constants.Urls.restroomsByLatAndLng(lat: lat, lng: lng))
        
        guard let resourceURL = URL(string: Constants.Urls.restroomsByLatAndLng(lat: lat, lng: lng)) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let _ = error {
                completion(.failure(.decodingError))
            } else {
                let restrooms = try? JSONDecoder().decode([Restroom].self, from: data)
                completion(.success(restrooms))
            }
        }.resume()
    }
}
