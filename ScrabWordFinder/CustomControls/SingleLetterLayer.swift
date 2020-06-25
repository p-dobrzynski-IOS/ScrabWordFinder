//
//  SingleLetter.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import CoreText

class SingleLetterLayer: CALayer {

    var char: Character = "?"
    var points: Int = 0

    init(ofCharacter character: Character) {
        super.init()
        
        char = Character(String(character).uppercased())
    }

    init(ofCharacter character: Character, ofLetterID letterID: String) {
        super.init()

        char = Character(String(character).uppercased())
        self.name = letterID
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        setupLayer()
    }

    private func setupLayer() {
        self.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockBackgroundColor)?.cgColor
        self.cornerRadius = self.frame.height / 15
        self.opacity = 1.0

        let letterCharLayer = CATextLayer()
        letterCharLayer.string = String(char).uppercased()
        letterCharLayer.frame = self.bounds
        letterCharLayer.fontSize = self.bounds.height - self.bounds.height/5
        letterCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
        letterCharLayer.alignmentMode = .center
        self.addSublayer(letterCharLayer)
        
        if !Constants.pointsAlphabet.contains(where: {$0.char == char}) {
            
            let errorBorderLayer = CALayer()
            errorBorderLayer.frame = self.bounds
            errorBorderLayer.cornerRadius = self.frame.height / 15
            errorBorderLayer.borderWidth = 3
            errorBorderLayer.borderColor = UIColor(named: Constants.Colors.scrabbleErrorFrameColor)?.cgColor
            self.addSublayer(errorBorderLayer)

        } else {
            let pointsCharLayer = CATextLayer()

            if let index = Constants.pointsAlphabet.firstIndex(where: {$0.char == char}) {
                pointsCharLayer.string = String(Constants.pointsAlphabet[index].value)
            }
            let pointLayerSize = CGSize(width: self.bounds.width/4, height: self.bounds.width/4)
            pointsCharLayer.fontSize = pointLayerSize.height*0.85
            pointsCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
            pointsCharLayer.frame = CGRect(origin: CGPoint(x: 3 * pointLayerSize.width, y: 3 * pointLayerSize.width), size: pointLayerSize)
            self.addSublayer(pointsCharLayer)
        }
    }

}
