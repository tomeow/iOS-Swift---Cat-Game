//
//  GameScene.swift
//  cat_Game
//
//  Created by Tomomi Tamura on 5/6/16.
//  Copyright (c) 2016 Tomomi Tamura. All rights reserved.
//

typealias CMAccelerometerHandler = (CMAccelerometerData?, NSError?) -> Void

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    //var dog = SKSpriteNode()
    var endNode = SKSpriteNode()
    var welcomeMessage = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNodeWithName("player") as! SKSpriteNode
        
        endNode = self.childNodeWithName("endNode") as! SKSpriteNode
        
        //dog = self.childNodeWithName("dog") as! SKSpriteNode
        
        welcomeMessage = self.childNodeWithName("welcomeMessage") as! SKLabelNode
        welcomeMessage.fontColor = UIColor.greenColor();
        welcomeMessage.text = "Welcome Home, Ruki-kun!"
        welcomeMessage.fontSize = 45
        welcomeMessage.position = CGPoint(x: 500, y: 1600)
        self.welcomeMessage.hidden = true

        
        manager.startAccelerometerUpdates()
        if manager.accelerometerAvailable
        {
            manager.accelerometerUpdateInterval = 0.1
        }
        
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){ (data, error) in
            
            self.physicsWorld.gravity = CGVectorMake(CGFloat((data?.acceleration.x)!) * 10, CGFloat((data?.acceleration.y)!) * 10)
            
        }
        
    }
    func didBeginContact(contact: SKPhysicsContact){
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1{
            //end message
            print("You won!")
            welcomeMessage.text = "Welcome Home!"
            welcomeMessage.hidden = false
            manager.accelerometerUpdateInterval = 0.5

        }
        else{
            welcomeMessage.hidden = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
