//
//  RestroomsReducer.swift
//  RestRoomFinder (iOS)
//
//  Created by Ding Lo on 18/7/2024.
//

import Foundation

func restroomsReducer(_ state: RestroomState, _ action: Action) -> RestroomState {
    var state = state
    
    switch action {
    case let action as SetRestroomAction:
        state.restroom = action.restrooms
    default:
        break
    }
    
    return state
}
