//
//  Helper.swift
//  RunForever
//
//  Created by Kirill on 1/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class Helper {

    class func currentVC() -> UIViewController {
        if let navVC = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController,
            let currentVC = navVC.visibleViewController {

            return currentVC
        }

        return UIViewController()
    }

}
