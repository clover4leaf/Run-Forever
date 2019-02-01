//
//  MainViewController.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backgroundScene: SKView!

    // MARK: - ACtions
    @IBAction func onPlay(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "gameScreen")
        self.navigationController?.pushViewController(view, animated: false)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if let scene = SKScene(fileNamed: "MenuGameScene") as? MenuGameScene {
            scene.scaleMode = .aspectFill
            scene.size = self.view.frame.size

            backgroundScene.presentScene(scene)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if let dbScore = UserDefaults.standard.value(forKey: "highscore") as? Int {
            scoreLabel.text = String(dbScore)
        }
    }
}
