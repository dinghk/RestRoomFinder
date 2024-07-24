//
//  RestroomMiddleware.swift
//  RestRoomFinder (iOS)
//
//  Created by Ding Lo on 18/7/2024.
//

import Foundation

func restroomMiddleware() -> Middleware<AppState> {
    return { state, action, dispatch in
        switch action {
        case let action as FetchRestroomAction:
            getRestroomByLatAndLng(action: action, dispatch: dispatch)
        default:
            break
        }
    }
}

private func getRestroomByLatAndLng(action: FetchRestroomAction, dispatch: @escaping Dispatcher) {
    Webservice().getRestroomsByLatAndLng(lat: action.latitude, lng: action.longitude) { result in
        switch result {
        case .success(let restrooms):
            if let restrooms = restrooms {
                dispatch(SetRestroomAction(restrooms: restrooms))
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
