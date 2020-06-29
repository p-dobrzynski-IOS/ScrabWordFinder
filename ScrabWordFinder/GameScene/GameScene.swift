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
    var YVector: CGFloat = -10.0
        
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
        
        let wordWordArray: [Character] = Array("WORDS")
        
        let boxSize: CGFloat = self.frame.width / CGFloat((wordWordArray.count + 2))
        
        for (index, char) in wordWordArray.enumerated() {
            let layer = SingleLetterLayer(ofCharacter: char, ofLetterID: String(char))
            layer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: boxSize, height: boxSize))
            
            let boxImage = imageFromLayer(layer: layer)
            let box = SKSpriteNode(texture: SKTexture(image: boxImage))
            box.position = CGPoint(x: (index+1) * Int(boxSize), y: Int(self.frame.height)/2)
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: boxSize, height: boxSize))
            box.physicsBody?.affectedByGravity = true
            box.physicsBody?.isDynamic = true
            addChild(box)
        }
    }
    
    func imageFromLayer(layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}
