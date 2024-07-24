//
//  Actions.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/15/20.
//

import Foundation

protocol Action { }

struct FetchRestroomAction: Action {
    let latitude: Double
    let longitude: Double
}


struct SetRestroomAction: Action {
    let restrooms: [Restroom]
}
