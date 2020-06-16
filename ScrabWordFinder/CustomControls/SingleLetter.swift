//
//  SingleLetter.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import CoreText

class SingleLetter: CALayer {

    var char: Character = "?"
    var points: Int = 0 

    var layerRect: CGRect = .zero

    init(inRect rect: CGRect) {
        super.init()
    }

    init(inRect rect: CGRect, ofCharacter character: Character) {
        super.init()

        setupLayer()
    }

    init(inRect rect: CGRect, ofCharacter character: Character, ofIndex index: Int) {
        super.init()

        layerRect = rect
        char = character

        self.name = String(index)
        
        setupLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayer() {
        self.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockBackgroundColor)?.cgColor
        self.cornerRadius = layerRect.height / 15
        self.frame = layerRect
        self.opacity = 1.0

        let letterCharLayer = CATextLayer()
        letterCharLayer.string = String(char)
        letterCharLayer.frame = self.bounds
        letterCharLayer.fontSize = self.bounds.height - self.bounds.height/5
        letterCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
        letterCharLayer.alignmentMode = .center
        self.addSublayer(letterCharLayer)

        if !Constants.pointsAlphabet.contains(where: {$0.char == char}) {
            let errorBorderLayer = CALayer()
            errorBorderLayer.frame = self.bounds
            errorBorderLayer.cornerRadius = layerRect.height / 15
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
