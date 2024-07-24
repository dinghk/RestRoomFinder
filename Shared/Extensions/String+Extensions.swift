//
//  String+Extentions.swift
//  RestRoomFinder
//
//  Created by Mohammad Azam on 10/14/20.
//

import Foundation

extension String {
    
    func encodeURL() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
}
