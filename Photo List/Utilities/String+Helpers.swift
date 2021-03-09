//
//  String+Helpers.swift
//  Photo List
//
//  Created by Nick Koster on 08/03/2021.
//

import Foundation

extension String {
    func uppercaseFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func uppercaseFirstLetter() {
        self = self.uppercaseFirstLetter()
    }
}
