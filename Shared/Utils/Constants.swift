//
//  Constants.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import Foundation

struct Constants {
    struct Urls {
        static func restroomsByLatAndLng(lat: Double, lng: Double) -> String {
//            "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=\(lat)&lng=\(lng)"
            "https://www.refugerestrooms.org/api/v1/restrooms/by_location?lat=40.701464&lng=-73.975336"
        }
    }
}
