//
//  Hero.swift
//  RunForever
//
//  Created by Kirill on 1/9/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

class Hero: GameObjects {

    var heroState = HeroState.run

    // MARK: - Initializers
    override init() {
        let texture = SKTexture(imageNamed: "run2.png")
        let size = CGSize(width: CGFloat(187.5), height: CGFloat(150.0))

        super.init(texture: texture, size: size)

        self.zPosition = 0

        configureBitMasks()
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.restitution = 0.0

        fallAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func fallAnimation() {
        let fall0  = SKTexture(imageNamed: "fall0")
        let fall1 = SKTexture(imageNamed: "fall1")

        let fallTextureArray = [fall0, fall1]

        let fallAnimation = SKAction.animate(with: fallTextureArray, timePerFrame: 0.1)
        let fallAction = SKAction.repeatForever(fallAnimation)

        self.run(fallAction) {
            self.runAnimation()
        }
    }

    func runAnimation() {
        print("runAnimation")

        heroState = .run
        
        let runHeroTexture = SKTexture(imageNamed: "run2.png")

        self.physicsBody = SKPhysicsBody(texture: runHeroTexture, size: size)
        configureBitMasks()
        self.physicsBody?.allowsRotation = false

        let run0 = SKTexture(imageNamed: "run0.png")
        let run1 = SKTexture(imageNamed: "run1.png")
        let run2 = SKTexture(imageNamed: "run2.png")
        let run3 = SKTexture(imageNamed: "run3.png")
        let run4 = SKTexture(imageNamed: "run4.png")
        let run5 = SKTexture(imageNamed: "run5.png")

        let runTextureArray = [run0, run1, run2, run3, run4, run5]

        let runAnimation = SKAction.animate(with: runTextureArray, timePerFrame: 0.1)
        let runAction = SKAction.repeatForever(runAnimation)

        self.run(runAction)
    }

    func jumpAnimation() {
        print("jumpAnimation")
        
        heroState = .jump

        let jump0 = SKTexture(imageNamed: "jump0.png")
        let jump1 = SKTexture(imageNamed: "jump1.png")
        let jump2 = SKTexture(imageNamed: "jump2.png")
        let jump3 = SKTexture(imageNamed: "jump3.png")

        let jumpTextureArray = [jump0, jump1, jump2, jump3, jump3, jump3, jump3, jump2, jump1, jump0]

        let jumpAnimation = SKAction.animate(with: jumpTextureArray, timePerFrame: 0.1)
        let jumpAction = SKAction.repeat(jumpAnimation, count: 1)

        self.run(jumpAction) {
            self.runAnimation()
        }
    }

    func startSlideAnimation() {
        print("startSlideAnimation")
        
        heroState = .slide

        let slideHeroTexture = SKTexture(imageNamed: "slide1")

        self.physicsBody = SKPhysicsBody(texture: slideHeroTexture, size: size)
        configureBitMasks()
        self.physicsBody?.allowsRotation = false

        let stand0 = SKTexture(imageNamed: "stand0")
        let stand1 = SKTexture(imageNamed: "stand1")
        let stand2 = SKTexture(imageNamed: "stand2")

        let startSlideTextureArray = [stand2, stand1, stand0]

        let startSlideAnimation = SKAction.animate(with: startSlideTextureArray, timePerFrame: 0.1)
        let startSlideAction = SKAction.repeat(startSlideAnimation, count: 1)

        self.run(startSlideAction) {
            self.slideAnimation()
        }
    }

    func finishSlideAnimation() {
        print("finishSlideAnimation")

        let stand0 = SKTexture(imageNamed: "stand0")
        let stand1 = SKTexture(imageNamed: "stand1")
        let stand2 = SKTexture(imageNamed: "stand2")

        let finishSlideTextureArray = [stand0, stand1, stand2]

        let finishSlideAnimation = SKAction.animate(with: finishSlideTextureArray, timePerFrame: 0.1)
        let finishSlideAction = SKAction.repeat(finishSlideAnimation, count: 1)

        self.run(finishSlideAction) {
            self.runAnimation()
        }
    }

    // MARK: - Private methods
    private func slideAnimation() {
        print("slideAnimation")

        let slide0 = SKTexture(imageNamed: "slide0.png")
        let slide1 = SKTexture(imageNamed: "slide1.png")

        let slideTextureArray = [slide0, slide1]

        let slideAnimation = SKAction.animate(with: slideTextureArray, timePerFrame: 0.1)
        let slideAction = SKAction.repeatForever(slideAnimation)

        self.run(slideAction)
    }

    private func configureBitMasks() {
        self.physicsBody?.categoryBitMask = GameObjects.heroBitMask
        self.physicsBody?.collisionBitMask = GameObjects.groundBitMask
        self.physicsBody?.contactTestBitMask = GameObjects.groundBitMask
    }

}
