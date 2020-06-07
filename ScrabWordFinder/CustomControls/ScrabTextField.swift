//
//  ScrabTextField.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit

class ScrabTextField: UITextField, UITextFieldDelegate, CAAnimationDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTexfield()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTexfield()
    }
    
    private func setupTexfield() {
        delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.autocorrectionType = .no
    }
    
    override func draw(_ rect: CGRect) {
        addBottomBorder()
    }
    
    func addBottomBorder() {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        borderLayer.frame = CGRect(origin: CGPoint(x: 0.0, y: (self.frame.size.height)-5), size: CGSize(width: self.frame.size.width, height: 5.0))
        self.layer.addSublayer(borderLayer)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    func getLetterLayer(inRect rect: CGRect, withLetter letter: Character) -> CALayer {
        
        let letterLayer = CALayer()
        letterLayer.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockBackgroundColor)?.cgColor
        letterLayer.cornerRadius = rect.height / 15
        letterLayer.frame = rect
        letterLayer.opacity = 1.0
        
        let letterCharLayer = CATextLayer()
        letterCharLayer.string = String(letter)
        letterCharLayer.frame = letterLayer.bounds
        letterCharLayer.fontSize = letterLayer.bounds.height - letterLayer.bounds.height/5
        letterCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
        letterCharLayer.alignmentMode = .center
        letterLayer.addSublayer(letterCharLayer)
        
        if !Constants.pointsAlphabet.contains(where: {$0.char == letter}) {
            let errorBorderLayer = CALayer()
            errorBorderLayer.frame = letterLayer.bounds
            errorBorderLayer.cornerRadius = rect.height / 15
            errorBorderLayer.borderWidth = 3
            errorBorderLayer.borderColor = UIColor(named: Constants.Colors.scrabbleErrorFrameColor)?.cgColor
            letterLayer.addSublayer(errorBorderLayer)
        } else {
            let pointsCharLayer = CATextLayer()
            
            if let index = Constants.pointsAlphabet.firstIndex(where: {$0.char == letter}) {
                pointsCharLayer.string = String(Constants.pointsAlphabet[index].value)
            }
            let pointLayerSize = CGSize(width: letterLayer.bounds.width/4, height: letterLayer.bounds.width/4)
            pointsCharLayer.fontSize = pointLayerSize.height*0.85
            pointsCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
            pointsCharLayer.frame = CGRect(origin: CGPoint(x: 3 * pointLayerSize.width, y: 3 * pointLayerSize.width), size: pointLayerSize)
            letterLayer.addSublayer(pointsCharLayer)
        }
        
        return letterLayer
    }
    
    override func drawText(in rect: CGRect) {
        
        if !self.text!.isEmpty {
            
            let lettersInTexfield: CGFloat = CGFloat(self.text!.count)
            
            let spaceBetweenLetters: CGFloat = 5.0
            
            let numberOfLettersInLine: CGFloat = 5.0
            
            let numberOfRows: CGFloat = 3.0
            
            let letterSize: CGFloat = (self.frame.width - spaceBetweenLetters * 2) / numberOfLettersInLine
            
            let letterSpacer: CGFloat = (self.bounds.height - 2 * letterSize) / numberOfRows
            
            var letterRect: CGRect = CGRect(origin: CGPoint(x: (letterSize + spaceBetweenLetters) * (lettersInTexfield - 1), y: letterSpacer), size: CGSize(width: letterSize, height: letterSize))
            
            if lettersInTexfield > numberOfLettersInLine {
                letterRect.origin = CGPoint(x: (letterSize + spaceBetweenLetters) * (lettersInTexfield - numberOfLettersInLine - 1), y: letterSize + letterSpacer * 2)
            }
            
            let letterLayer = getLetterLayer(inRect: letterRect, withLetter: self.text!.uppercased().last!)
            self.layer.addSublayer(letterLayer)
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = CGPoint(x: letterLayer.position.x, y: -500)
            animation.toValue = letterLayer.position
            animation.duration = 0.3
            animation.delegate = self
            letterLayer.add(animation, forKey: "basic")
        }
    }
    
    func shakeTexfield() {
        let shake = CABasicAnimation(keyPath: "position")
        let xDelta = CGFloat(5)
        shake.duration = 0.15
        shake.repeatCount = 1
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: self.center.x - xDelta, y: self.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: self.center.x + xDelta, y: self.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.layer.add(shake, forKey: "position")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count == 0 && range.length > 0 {
            // Back pressed
            if self.layer.sublayers!.count > 3 {
                self.layer.sublayers?.popLast()
            }
            return false
        }
        
        return true
    }
}
