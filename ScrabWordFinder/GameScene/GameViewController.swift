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

class GameViewController: UIViewController {

    override func viewDidLoad() {
        let scene: GameScene = GameScene(size: view.bounds.size)

        // swiftlint:disable force_cast
        let skView = self.view as! SKView
        // swiftlint:enable force_cast
        skView.showsFPS = true
        skView.showsNodeCount = true

        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }

}
