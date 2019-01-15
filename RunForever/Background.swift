//
//  Background.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class Background: SKNode {

    private var frameSize = CGSize()

    init(frameSize: CGSize) {
        super.init()

        self.frameSize = frameSize

        var texture = SKTexture(imageNamed: "HillsLayer0.png")
        let backgroundSpriteNode = SKSpriteNode(texture: texture)
        backgroundSpriteNode.zPosition = -10
        backgroundSpriteNode.size = frameSize

        self.addChild(backgroundSpriteNode)

        texture = SKTexture(imageNamed: "HillsLayer1.png")
        createLayerWith(texture: texture, duration: 30, zPosition: -9)

        texture = SKTexture(imageNamed: "HillsLayer2.png")
        createLayerWith(texture: texture, duration: 25, zPosition: -8)

        texture = SKTexture(imageNamed: "HillsLayer3.png")
        createLayerWith(texture: texture, duration: 15, zPosition: -7)

        texture = SKTexture(imageNamed: "HillsLayer4.png")
        createLayerWith(texture: texture, duration: 2, zPosition: -6)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createLayerWith(texture: SKTexture, duration: TimeInterval, zPosition: CGFloat) {
        var backgroundSpriteNode = SKSpriteNode(texture: texture)

        let moveBackground = SKAction.moveBy(x: -frameSize.width, y: 0, duration: duration)
        let replaceBackground = SKAction.moveBy(x: frameSize.width, y: 0, duration: 0)
        let moveBackgroundForever = SKAction.repeatForever(SKAction.sequence([moveBackground, replaceBackground]))

        for index in 0...1 {
            backgroundSpriteNode = SKSpriteNode(texture: texture)
            backgroundSpriteNode.zPosition = zPosition
            backgroundSpriteNode.size = frameSize

            let xPosition = CGFloat(index) * frameSize.width
            let yPosition = CGFloat(0)

            backgroundSpriteNode.position = CGPoint(x: xPosition, y: yPosition)
            backgroundSpriteNode.run(moveBackgroundForever)

            self.addChild(backgroundSpriteNode)
        }
    }

}
