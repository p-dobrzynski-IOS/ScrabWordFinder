//
//  SingleLetter.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import CoreText

class SingleLetter: UIView {
        
    var letter: Character = "?"

    //initWithFrame to init view from code
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    //common func to init our view
    private func setupView() {
//      backgroundColor = .red
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let letterFramePath: UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 3)
        let letterFrameLayer: CAShapeLayer = {
            let layer = CAShapeLayer()
            layer.path = letterFramePath.cgPath
            layer.fillColor = UIColor.white.cgColor
            return layer
        }()
        self.layer.addSublayer(letterFrameLayer)
        
        let characterLetter: CATextLayer = {
            let textLayer = CATextLayer()
            textLayer.string = letter
            textLayer.fontSize = 10
            return textLayer
        }()
        self.layer.addSublayer(characterLetter)
    }

    func setCharacter(letterCharacter: Character) {
        letter = letterCharacter
        setNeedsDisplay()
    }

}
