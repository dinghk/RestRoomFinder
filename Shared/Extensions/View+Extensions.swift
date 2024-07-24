//
//  View+Extensions.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
