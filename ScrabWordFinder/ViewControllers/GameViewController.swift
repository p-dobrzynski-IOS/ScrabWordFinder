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
    
    let enterButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Enter", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        self.view = SKView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {

        // Adding gamescene to view
        setupGameView()

        // Adding UI elements to view
        setupView()
    }

    private func setupGameView() {
        let scene: GameScene = GameScene(size: view.frame.size)
        // swiftlint:disable force_cast
        let skView = self.view as! SKView
        // swiftlint:enable force_cast
        skView.showsFPS = true
        skView.showsNodeCount = true

        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }

    private func setupView() {
        self.view.addSubview(enterButton)

        enterButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }

    @objc private func buttonPressed(sender: UIButton) {
        performSegue(withIdentifier: Constants.MainToEnterSegue, sender: self)
    }

}
