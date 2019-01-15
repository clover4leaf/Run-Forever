//
//  GameViewController.swift
//  ForeverRun
//
//  Created by Kirill on 1/6/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: - Privates
    private var gameScene = MainGameScene()

    // MARK: - Actions
    @IBAction func onPause(_ sender: Any) {
        gameScene.pauseButtonAction()

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        if let pauseVC = storyBoard.instantiateViewController(withIdentifier: "pauseScreen") as? PauseViewController {
            pauseVC.scene = gameScene
            self.addChild(pauseVC)
            self.view.addSubview(pauseVC.view)
            pauseVC.didMove(toParent: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "MainGameScene") {
                scene.scaleMode = .aspectFill

                if let game = scene as? MainGameScene {
                    gameScene = game
                }
                view.showsPhysics = true

                view.presentScene(scene)
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func showScoreWith(score: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        if let scoreVC = storyBoard.instantiateViewController(withIdentifier: "scoreScreen") as? ScoreViewController {
            scoreVC.score = score
            scoreVC.gameScene = gameScene
            self.addChild(scoreVC)
            self.view.addSubview(scoreVC.view)
            scoreVC.didMove(toParent: self)
        }
    }

    func showHints() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        if let firstPlayVC = storyBoard.instantiateViewController(withIdentifier: "firstPlay") as? FirstPlayViewController {
            self.addChild(firstPlayVC)
            self.view.addSubview(firstPlayVC.view)
            firstPlayVC.didMove(toParent: self)
        }
    }

}
