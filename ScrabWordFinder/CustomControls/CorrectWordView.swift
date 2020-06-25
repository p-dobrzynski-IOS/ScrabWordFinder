//
//  CorrectWordView.swift
//  ScrabWordFinder
//
//  Created by Piotr on 16/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit

class CorrectWordView: UIView {
    
    var viewWord: String = "" {
        didSet {
            setupView()
        }
    }
    
    init(forWord word: String) {
        super.init(frame: .zero)
        viewWord = word
        
        self.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColorDarken)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupView()
    }
    
    func setupView() {
                
        // Creating border layer for view
        let yourViewBorder: CAShapeLayer = {
            let layer: CAShapeLayer = CAShapeLayer()
            layer.strokeColor = UIColor.gray.cgColor
            layer.lineDashPattern = [6, 3]
            layer.frame = self.bounds
            layer.fillColor = nil
            layer.path = UIBezierPath(roundedRect: self.bounds.insetBy(dx: 5, dy: 5), cornerRadius: 5).cgPath
            layer.opacity = 0.5
            return layer
        }()
            
        // Adding border layer to view
        self.layer.addSublayer(yourViewBorder)
        
        // Adding letters for view
        let lettersRect = self.frame.inset(by: UIEdgeInsets(top: -5, left: 5, bottom: 5, right: -5))

        let margin = lettersRect.height / 15
        
        let blockSize: CGFloat = {
            var size: CGFloat = (lettersRect.width - margin * 10) / 10
            if size >= lettersRect.height {
                size = lettersRect.height - 2 * margin
            }
            return size
        }()
                
        let xOrigin = blockSize
        
        // Adding single letters layers to view
        for (charIndex, char) in viewWord.enumerated() {
            let letterLayer = SingleLetterLayer(ofCharacter: char)
            letterLayer.frame = CGRect(x: CGFloat(charIndex) * (xOrigin+margin) + lettersRect.origin.x, y: (lettersRect.height - blockSize)/2, width: blockSize, height: blockSize)
            self.layer.addSublayer(letterLayer)
        }
    }
}
