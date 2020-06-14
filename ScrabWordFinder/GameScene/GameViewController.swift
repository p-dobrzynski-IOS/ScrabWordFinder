//
//  GameViewController.swift
//  ScrabWordFinder
//
//  Created by Piotr on 11/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    let label = UILabel()
    
    override func loadView() {
        self.view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        let scene: GameScene = GameScene(size: view.frame.size)

        // swiftlint:disable force_cast
        let skView = self.view as! SKView
        // swiftlint:enable force_cast
        skView.showsFPS = true
        skView.showsNodeCount = true

        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
        
        self.view.addSubview(label)
        label.text = "SDAD"
        label.backgroundColor = UIColor.white
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        
    }

}
