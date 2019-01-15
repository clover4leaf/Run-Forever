//
//  ScoreViewController.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    // MARK: - Publics
    var score = Int()
    var gameScene = MainGameScene()

    // MARK: - Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var fieldView: UIView!

    // MARK: - Actions
    @IBAction func onPlay(_ sender: Any) {
        gameScene.createGame()
        self.view.removeFromSuperview()
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        fieldView.backgroundColor = UIColor.clear

        if let dbScore = UserDefaults.standard.value(forKey: "highscore") as? Int {
            bestLabel.text = String(dbScore)
            scoreLabel.text = String(score)

            if dbScore < score {
                saveScore()
            }

        } else {
            bestLabel.text = "0"
            scoreLabel.text = String(score)

            saveScore()
        }
    }

    // MARK: - Private methods
    private func saveScore() {
        UserDefaults.standard.set(score, forKey: "highscore")
        UserDefaults.standard.synchronize()
    }
}
