//
//  LoadingHUD.swift
//  Photo List
//
//  Created by Nick Koster on 09/03/2021.
//

import UIKit
import MBProgressHUD

struct LoadingHUD {
    static func showLoadingHUD(forView view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading..."
    }

    static func hideLoadingHUD(forView view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
