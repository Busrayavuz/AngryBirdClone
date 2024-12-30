//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Büşra Sağır on 28.12.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    var box1OriginalPosition: CGPoint?
    var box2OriginalPosition: CGPoint?
    var box3OriginalPosition: CGPoint?
    var box4OriginalPosition: CGPoint?
    var box5OriginalPosition: CGPoint?
    
    //Hem pozisyonları hem de rotasyonları saklamak için
    var initialBoxPositions: [String: CGPoint] = [:]
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
        case Ground = 4
        case Tree = 8
    }
    
    func resetGame() {
        if let box1 = childNode(withName: "box1") as? SKSpriteNode {
            box1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            box1.physicsBody?.angularVelocity = 0
            box1.position = initialBoxPositions["box1"]!
            box1.zRotation = 0
        }
        
        if let box2 = childNode(withName: "box2") as? SKSpriteNode {
            box2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            box2.physicsBody?.angularVelocity = 0
            box2.position = initialBoxPositions["box2"]!
            box2.zRotation = 0
        }
        
        if let box3 = childNode(withName: "box3") as? SKSpriteNode {
            box3.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            box3.physicsBody?.angularVelocity = 0
            box3.position = initialBoxPositions["box3"]!
            box3.zRotation = 0
        }
        
        if let box4 = childNode(withName: "box4") as? SKSpriteNode {
            box4.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            box4.physicsBody?.angularVelocity = 0
            box4.position = initialBoxPositions["box4"]!
            box4.zRotation = 0
        }
        
        if let box5 = childNode(withName: "box5") as? SKSpriteNode {
            box5.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            box5.physicsBody?.angularVelocity = 0
            box5.position = initialBoxPositions["box5"]!
            box5.zRotation = 0
        }
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFill
        self.physicsWorld.contactDelegate = self
        
        if let box1 = childNode(withName: "box1") as? SKSpriteNode {
            initialBoxPositions["box1"] = box1.position
        }
        
        if let box2 = childNode(withName: "box2") as? SKSpriteNode {
            initialBoxPositions["box2"] = box2.position
        }
        
        if let box3 = childNode(withName: "box3") as? SKSpriteNode {
            initialBoxPositions["box3"] = box3.position
        }
        
        if let box4 = childNode(withName: "box4") as? SKSpriteNode {
            initialBoxPositions["box4"] = box4.position
        }
        
        if let box5 = childNode(withName: "box5") as? SKSpriteNode {
            initialBoxPositions["box5"] = box5.position
        }
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        originalPosition = bird.position
        let birdTexture = SKTexture(imageNamed: "bird")
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 18)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        bird.physicsBody?.friction = 0.8
        bird.physicsBody?.angularDamping = 1.0
        bird.physicsBody?.linearDamping = 0.5
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 6, height: boxTexture.size().height / 6)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf:size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.4
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf:size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.4
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf:size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.4
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf:size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.4
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf:size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.4
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        scoreLabel.fontName = "Helvatica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue{
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
         bird.physicsBody?.affectedByGravity = true*/
        
        if gameStarted == false {
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if gameStarted == false {
            if let touch = touches.first, gameStarted == false {
                let touchLocation = touch.location(in: self)
                bird.position = touchLocation
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 &&
                birdPhysicsBody.velocity.dy <= 0.1 &&
                birdPhysicsBody.angularVelocity <= 0.1 &&
                gameStarted == true
            {
                // Kuşu sıfırla
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                bird.zRotation = 0
                // Oyunu sıfırla
                resetGame()
                
                // Skor ve oyun durumu
                gameStarted = false
                score = 0
                scoreLabel.text = String(score)
                
                
            }
        }
        
        
    }
}
