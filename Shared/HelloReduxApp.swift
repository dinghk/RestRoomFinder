//
//  HelloReduxApp.swift
//  Shared
//
//  Created by Mohammad Azam on 9/14/20.
//

import SwiftUI

@main
struct HelloReduxApp: App {
    
    init() {
        configureTheme()
    }
    
    var body: some Scene {
       
        let store = Store(
            reducer: appReducer,
            state: AppState(),
            middlewares: [restroomMiddleware()]
        )
        
        WindowGroup {
            HomeScreen().environmentObject(store)
        }
    }
    
    private func configureTheme() {
        UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
    }
}
