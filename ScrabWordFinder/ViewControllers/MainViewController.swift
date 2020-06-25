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
import Lottie

class MainViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Pacifico-Regular", size: 65)
        label.textColor = .white
        label.text = "Scrabble \n Finder"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Tap to Start"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let clickAnimationView: AnimationView = {
        let animationView: AnimationView = AnimationView()
        animationView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        animationView.layer.cornerRadius = 20
        return animationView
    }()
    
    let enterButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased(sender:)), for: .touchDown)
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
        
        // Start animation
        startAnimation()
    }

    private func setupGameView() {
        let scene: GameScene = GameScene(size: view.frame.size)
        // swiftlint:disable force_cast
        let skView = self.view as! SKView
        // swiftlint:enable force_cast
//        skView.showsFPS = true
//        skView.showsNodeCount = true

//        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill

        skView.presentScene(scene)
    }

    private func setupView() {
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.leftMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.bottom.equalTo(self.view.snp.centerY)
        }
        
        self.view.addSubview(clickAnimationView)
        
        clickAnimationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.width.equalTo(self.view.snp.width).dividedBy(2)
            make.height.equalTo(self.view.snp.width).dividedBy(2)
        }
                
        self.view.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(clickAnimationView.snp.top)
            make.left.equalTo(clickAnimationView.snp.leftMargin)
            make.right.equalTo(clickAnimationView.snp.rightMargin)
            make.height.equalTo(clickAnimationView.snp.height).dividedBy(3)
        }
        
        self.view.addSubview(enterButton)
        
        enterButton.snp.makeConstraints { (make) in
            make.edges.equalTo(clickAnimationView.snp.edges)
        }
    }
    
    private func startAnimation() {
        let animation = Animation.named("7637-tap-click")
        clickAnimationView.animation = animation
        clickAnimationView.contentMode = .scaleAspectFit
        clickAnimationView.loopMode = .loop
        clickAnimationView.play()
    }

    @objc private func buttonPressed(sender: UIButton) {
        clickAnimationView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25)
        performSegue(withIdentifier: Constants.MainToEnterSegue, sender: self)
    }
    
    @objc private func buttonReleased(sender: UIButton) {
        clickAnimationView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    }
    
}

extension UIViewController {
    
    func setCustomNavigationButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named: "arrow"), for: .normal)
        menuBtn.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        menuBtn.layer.masksToBounds = false
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 38)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 38)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
