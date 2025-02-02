//
//  AppReducer.swift
//  CombiningReducers
//
//  Created by Mohammad Azam on 9/15/20.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.restrooms = restroomsReducer(state.restrooms, action)
    return state
}
