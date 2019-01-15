//
//  GameScene.swift
//  CosmoWars
//
//  Created by Kirill on 1/5/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum GameState {
    case play
    case pause
    case lose
}

enum HeroState {
    case run
    case slide
    case jump
}

enum EnemyType: Int {
    case cactus = 0
    case bird = 1
}

class MainGameScene: SKScene, SKPhysicsContactDelegate {

    // MARK: - Public methods
    func pauseButtonAction() {
        self.isPaused = !self.isPaused

        gameState == .play ? pauseGame() : resumeGame()
    }

    // MARK: - Privates
    private var score = Int()
    private var musicPlayer = AVAudioPlayer()
    private var scoreTimer = Timer()
    private var enemyTimer = Timer()
    private var hero = Hero()
    private var heroState = HeroState.run
    private var onGround = false
    private var gameState = GameState.play

    // MARK: - Nodes
    private var scoreLabel = SKLabelNode()

    // MARK: - Life Cycle
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self

        firstTimePlaying()
        createGame()
    }

    override func didSimulatePhysics() {
        let deadlinePositionX = CGFloat(-self.frame.size.width - 100)

        enumerateChildNodes(withName: "cactus") { (cactus, _) in
            if cactus.calculateAccumulatedFrame().origin.x.isLess(than: deadlinePositionX) {
                cactus.removeFromParent()
            }
        }

        enumerateChildNodes(withName: "bird") { (bird, _) in
            if bird.calculateAccumulatedFrame().origin.x.isLess(than: deadlinePositionX) {
                bird.removeFromParent()
            }
        }
    }

    // MARK: - Private methods
    func createGame() {
        score = 0

        createScoreTimer()

        createBackground()
        createScoreLabel()
        createGround()
        createHero()

        gameState = .play

        createEnemyObjects()

        playMusic()
    }

    private func playMusic() {
        musicPlayer = AVAudioPlayer()

        if let musicPath = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: nil)
                musicPlayer.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func createBackground() {
        let background = Background(frameSize: frame.size)

        let backgroundNode = SKNode()
        backgroundNode.addChild(background)

        self.addChild(backgroundNode)
    }

    private func createGround() {
        let size = self.frame.size

        let ground = Ground(frameSize: size)

        let groundNode = SKNode()
        groundNode.name = "ground"
        groundNode.addChild(ground)
        self.addChild(groundNode)
    }

    private func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Helvetica Neue Condensed Bold")
        scoreLabel.text = "SCORE: 0"
        scoreLabel.fontSize = 65
        scoreLabel.fontColor = SKColor.black

        let xPosition = self.frame.midX
        let yPosition = self.frame.size.height/2 - 100

        scoreLabel.position = CGPoint(x: xPosition, y: yPosition)
        scoreLabel.zPosition = 10

        addChild(scoreLabel)
    }

    private func createHero() {
        hero = Hero()

        let heroNode = SKNode()
        heroNode.name = "hero"
        heroNode.addChild(hero)

        let xPosition = -self.frame.size.width/2 + 150
        let yPosition = -self.frame.size.height/2 + 500

        heroNode.position = CGPoint(x: xPosition, y: yPosition)

        self.addChild(heroNode)
    }

    private func createEnemyObjects() {
        enemyTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (_) in
            let enemyCount = self.randomEnemyCount()
            let enemyType = self.randomEnemyType()

            if enemyType == EnemyType.cactus {
                if enemyCount == 3 {
                    self.createCactus(count: 2)
                    return
                }

                self.createCactus(count: enemyCount)
            } else {
                self.createBird(count: enemyCount)
            }
        }
    }

    private func randomEnemyCount() -> Int {
        let count = Int.random(in: 1...3)
        return count
    }

    private func randomEnemyType() -> EnemyType {
        let randomNumber = Int.random(in: 0...1)
        return randomNumber == EnemyType.cactus.rawValue ? EnemyType.cactus : EnemyType.bird
    }

    private func createBird(count: Int) {
        let speed = speedCalcutor()

        for index in 0..<count {
            let bird = Bird(speed: speed)

            let birdNode = SKNode()
            birdNode.name = "bird"
            birdNode.addChild(bird)

            let xPosition = self.frame.size.width/2 + (CGFloat(index) * bird.frame.size.width + 5)
            let yPosition = CGFloat(-200)

            birdNode.position = CGPoint(x: xPosition, y: yPosition)

            self.addChild(birdNode)
        }
    }

    private func createCactus(count: Int) {
        let speed = speedCalcutor()

        for index in 0..<count {
            let cactus = Cactus(speed: speed)

            let cactusNode = SKNode()
            cactusNode.name = "cactus"
            cactusNode.addChild(cactus)

            let xPosition = self.frame.size.width/2 + (CGFloat(index) * cactus.frame.size.width + 5)
            let yPosition = CGFloat(-300)

            cactusNode.position = CGPoint(x: xPosition, y: yPosition)

            self.addChild(cactusNode)
        }
    }

    private func pauseGame() {
        scoreTimer.invalidate()
        enemyTimer.invalidate()
        gameState = .pause
        musicPlayer.pause()
    }

    private func resumeGame() {
        createScoreTimer()
        createEnemyObjects()
        gameState = .play
        musicPlayer.play()
    }

    private func createScoreTimer() {
        scoreTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.score += 1
            self.scoreLabel.text = "SCORE: \(self.score)"
        }
    }

    private func endGame() {
        if gameState == .lose { return }

        scoreTimer.invalidate()
        enemyTimer.invalidate()

        self.removeAllActions()
        self.removeAllChildren()

        if let scoreVC = Helper.currentVC() as? GameViewController {
            scoreVC.showScoreWith(score: score)
        }

        gameState = .lose
    }

    private func speedCalcutor() -> CGFloat {
        let speed = CGFloat(500 + score)
        return speed
    }

    private func firstTimePlaying() {
        if UserDefaults.standard.value(forKey: "firstPlay") != nil {
            return
        } else {
            if let scoreVC = Helper.currentVC() as? GameViewController {
                scoreVC.showHints()
            }

            UserDefaults.standard.set(true, forKey: "firstPlay")
            UserDefaults.standard.synchronize()
        }
    }

    // MARK: - Contacts
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask

        let heroBitMask = GameObjects.heroBitMask
        let cactusBitMask = GameObjects.cactusBitMask
        let birdBitMask = GameObjects.birdBitMask
        let groundBitMask = GameObjects.groundBitMask

        if ((bodyA == heroBitMask && bodyB == cactusBitMask) || (bodyA == cactusBitMask && bodyB == heroBitMask)) {
            endGame()
        } else if ((bodyA == heroBitMask && bodyB == birdBitMask) || (bodyA == birdBitMask && bodyB == heroBitMask)) {
            endGame()
        } else if ((bodyA == heroBitMask && bodyB == groundBitMask) || (bodyA == groundBitMask && bodyB == heroBitMask)) {
            onGround = true
        }
    }

    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")

        for touch in touches {
            let touchLocation = touch.location(in: self).x
            let midXScreen = self.frame.size.width/2

            let screenSide = touchLocation/midXScreen

            if onGround {
                if screenSide.isLess(than: CGFloat(0.0)) {
                    hero.startSlideAnimation()
                    heroState = .slide
                } else {
                    hero.jumpAnimation()
                    jumpAction()
                    onGround = false
                    heroState = .jump
                }
            }
        }
    }

    private func jumpAction() {
        if onGround {
            hero.physicsBody?.velocity = CGVector.zero
            hero.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 80.0))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            print("touchesEnded")

            let touchLocation = touch.location(in: self).x
            let midXScreen = self.frame.size.width/2

            let screenSide = touchLocation/midXScreen

            if screenSide.isLess(than: CGFloat(0.0)) {
                hero.finishSlideAnimation()
            }
        }
    }

}
