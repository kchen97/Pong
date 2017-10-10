//
//  GameScene.swift
//  Pong
//
//  Created by Korman Chen on 10/9/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var ball = SKSpriteNode()
    var CPU = SKSpriteNode()
    var player = SKSpriteNode()
    
    var playerScoreLabel = SKLabelNode()
    var cpuScoreLabel = SKLabelNode()
    
    var score = [Int]()
    var ballSpeed = 15
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        CPU = self.childNode(withName: "PaddleCPU") as! SKSpriteNode
        player = self.childNode(withName: "PaddlePLYR") as! SKSpriteNode
        
        CPU.position.y = (self.frame.height / 2) - 50
        player.position.y = (-self.frame.height / 2) + 50
        
        playerScoreLabel = self.childNode(withName: "PlayerScoreLabel") as! SKLabelNode
        cpuScoreLabel = self.childNode(withName: "CPUScoreLabel") as! SKLabelNode
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            player.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    
    func startGame() {
        score = [0, 0]
        playerScoreLabel.text = "\(score[0])"
        cpuScoreLabel.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: -ballSpeed, dy: -ballSpeed))
    }
    
    func addScore(winningPlayer: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if winningPlayer == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: ballSpeed, dy: ballSpeed))
        }
        else {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -ballSpeed, dy: -ballSpeed))
        }
        
        playerScoreLabel.text = "\(score[0])"
        cpuScoreLabel.text = "\(score[1])"
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        switch currentGameType {
        case .easy:
            CPU.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .medium:
            CPU.run(SKAction.moveTo(x: ball.position.x, duration: 0.85))
            break
        case .hard:
            CPU.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            ballSpeed = 20
            break
        }
        
        if ball.position.y <= player.position.y - 30 {
            addScore(winningPlayer: CPU)
        }
        else if ball.position.y >= CPU.position.y + 30 {
            addScore(winningPlayer: player)
        }
    }
}
