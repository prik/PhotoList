//
//  LoadingHUD.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import UIKit
import MBProgressHUD

struct LoadingHUD {
    static func show(forView view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading..."
    }

    static func hide(forView view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
