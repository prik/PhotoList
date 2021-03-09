//
//  Alert.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import UIKit

struct Alert {
    static func error(withMessage message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
}
