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

    init(speed: CGFloat) {
        let cactusTexture = SKTexture(imageNamed: "cactus.png")
        let size = CGSize(width: CGFloat(93.75), height: CGFloat(93.75))

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
