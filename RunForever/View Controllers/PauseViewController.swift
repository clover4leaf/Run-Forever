//
//  PauseViewController.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {

    // MARK: - Publics
    var scene = MainGameScene()

    // MARK: - Outlets
    @IBOutlet private weak var fieldView: UIView!

    // MARK: - Actions
    @IBAction func onResume(_ sender: Any) {
        scene.pauseButtonAction()

        self.view.removeFromSuperview()
    }

    @IBAction func onMenu(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        fieldView.backgroundColor = UIColor.clear
    }
}
