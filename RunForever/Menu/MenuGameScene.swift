//
//  MenuGameScene.swift
//  RunForever
//
//  Created by Kirill on 1/8/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import GameplayKit

class MenuGameScene: SKScene {

    var frameSize = CGSize()

    override func didMove(to view: SKView) {
        createBackground()
    }

    // MARK: - Private methods
    private func createBackground() {
        let background = Background(frameSize: self.frame.size)

        let backgroundNode = SKNode()
        backgroundNode.addChild(background)

        self.addChild(backgroundNode)
    }
}
