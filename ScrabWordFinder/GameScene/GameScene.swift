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

class GameScene: SKScene {
    
    var motionManager = CMMotionManager()
    var XVector: CGFloat = 0.0
    var YVector: CGFloat = 0.0
    
    override func didMove(to view: SKView) {

        // Setting backgrdoung for gamesene
        self.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)!

        // Adding egde physics for gamescene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

        // Upadting view on gyroscope motion
        if motionManager.isGyroAvailable {
            self.motionManager.gyroUpdateInterval = 1.0 / 60.0
            self.motionManager.startGyroUpdates()
            
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
                if let myData = data {
                            
                    self.YVector = -CGFloat(myData.attitude.pitch/Double.pi * 20)
                    self.XVector = CGFloat(myData.attitude.roll/Double.pi * 20)
                } else {
                    print(error)
                }
            }
        }

        addScrabbleBoxes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.physicsWorld.gravity=CGVector(dx: XVector, dy: YVector)
    }

    func addScrabbleBoxes() {
        for index in 0..<5 {
            let box = SKSpriteNode(color: UIColor(named: Constants.Colors.scrabbleBlockBackgroundColor)!, size: CGSize(width: 64, height: 64))
            box.position = CGPoint(x: 64 * index, y: 64 * index)
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
            addChild(box)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        let location = touch.location(in: self)
//        let box =
//        box.position = location
//
//        addChild(box)
//    }
}
