//
//  GameScene.swift
//  ScrabWordFinder
//
//  Created by Piotr on 11/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var motionManager = CMMotionManager()
    var XVector: CGFloat = 0.0
    var YVector: CGFloat = 0.0
    
    var boxesSprites: [SKSpriteNode] = [SKSpriteNode]()
    
    override func sceneDidLoad() {
        addScrabbleBoxes()
    }
    
    override func didMove(to view: SKView) {
        
        self.scene?.physicsWorld.contactDelegate = self
        
        // Setting backgrdoung for gamesene
        self.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)!
        
        // Adding egde physics for gamescene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Upadting view on gyroscope motion
        
        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
            
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let myData = data {
                    if -0.1...0.1 ~= myData.acceleration.y || -0.1...0.1 ~= myData.acceleration.x {
                        return
                    }
                    
                    self.YVector = CGFloat(myData.acceleration.y * 35)
                    self.XVector = CGFloat(myData.acceleration.x * 35)
                } else {
                    print(error!)
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact")
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.physicsWorld.gravity=CGVector(dx: XVector, dy: YVector)
    }
    
    func addScrabbleBoxes() {
        for index in 0..<5 {
            let box = SKSpriteNode(color: UIColor(named: Constants.Colors.scrabbleBlockBackgroundColor)!, size: CGSize(width: 64, height: 64))
            box.position = CGPoint(x: index*64, y: index*64)
            //            box.name = "box"
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            box.physicsBody?.affectedByGravity = true
            box.physicsBody?.isDynamic = true
            boxesSprites.append(box)
            addChild(box)
        }
    }
}
