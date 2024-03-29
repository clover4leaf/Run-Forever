//
//  Cactus.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class Cactus: GameObjects {

    init(speed: CGFloat, frameSize: CGSize) {
        let cactusTexture = SKTexture(imageNamed: "cactus.png")

        let cactusWidth = CGFloat(frameSize.width / 14)
        let cactusHeight = CGFloat(frameSize.height / 9)
        let size = CGSize(width: cactusWidth, height: cactusHeight)

        super.init(texture: cactusTexture, size: size)

        self.zPosition = 0

        self.physicsBody?.categoryBitMask = GameObjects.cactusBitMask
        self.physicsBody?.collisionBitMask = GameObjects.heroBitMask
        self.physicsBody?.contactTestBitMask = GameObjects.heroBitMask
        self.physicsBody?.velocity = CGVector(dx: -speed, dy: 0.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
