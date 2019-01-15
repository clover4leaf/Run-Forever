//
//  Bird.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class Bird: GameObjects {

    init(speed: CGFloat) {
        let birdTexture = SKTexture(imageNamed: "bird4.png")
        let size = CGSize(width: CGFloat(93.75), height: CGFloat(93.75))

        super.init(texture: birdTexture, size: size)

        self.zPosition = 0

        self.physicsBody?.categoryBitMask = GameObjects.birdBitMask
        self.physicsBody?.collisionBitMask = GameObjects.heroBitMask
        self.physicsBody?.contactTestBitMask = GameObjects.heroBitMask
        self.physicsBody?.velocity = CGVector(dx: -speed, dy: 0.0)

        let bird0 = SKTexture(imageNamed: "bird0.png")
        let bird1 = SKTexture(imageNamed: "bird1.png")
        let bird2 = SKTexture(imageNamed: "bird2.png")
        let bird3 = SKTexture(imageNamed: "bird3.png")
        let bird4 = SKTexture(imageNamed: "bird4.png")

        let birdFlyTextureArray = [bird0, bird1, bird2, bird3, bird4]

        let flyAnimation = SKAction.animate(with: birdFlyTextureArray, timePerFrame: 0.1)
        let flyAction = SKAction.repeatForever(flyAnimation)

        self.run(flyAction)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
