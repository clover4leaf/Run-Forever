//
//  GameObjects.swift
//  RunForever
//
//  Created by Kirill on 1/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameObjects: SKSpriteNode {

    static let groundBitMask: UInt32 = 0x1 << 1
    static let heroBitMask: UInt32 = 0x1 << 2
    static let birdBitMask: UInt32 = 0x1 << 3
    static let cactusBitMask: UInt32 = 0x1 << 4

    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize())
    }

    init(texture: SKTexture!, size: CGSize) {
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.size = size

        self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)

        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
