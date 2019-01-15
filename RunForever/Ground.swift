//
//  Ground.swift
//  RunForever
//
//  Created by Kirill on 1/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class Ground: GameObjects {

    override init() {
        super.init()
    }

    init(frameSize: CGSize) {
        super.init()

        self.zPosition = 0

        self.size = CGSize(width: frameSize.width, height: frameSize.height/15)

        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frameSize.width, height: frameSize.height/10))
        self.physicsBody?.categoryBitMask = GameObjects.groundBitMask
        self.physicsBody?.collisionBitMask = GameObjects.heroBitMask
        self.physicsBody?.contactTestBitMask = GameObjects.heroBitMask
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0.0

        self.position = CGPoint(x: 100, y: -frameSize.height/2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
