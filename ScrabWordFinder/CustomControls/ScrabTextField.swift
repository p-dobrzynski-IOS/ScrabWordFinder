//
//  ScrabTextField.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit

class ScrabTextField: UITextField, UITextFieldDelegate, CAAnimationDelegate {
    
    var lastTexfieldText: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTexfield()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTexfield()
    }
    
    // Initial setup for textfield
    private func setupTexfield() {
        delegate = self
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.autocorrectionType = .no
        self.tintColor = UIColor.clear
    }
    
    // Overriding build in function
    override func draw(_ rect: CGRect) {
        
        // Drawing bottom border
        addBottomBorder()
    }
    
    // Adding bottom bar to Texfield
    func addBottomBorder() {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        borderLayer.frame = CGRect(origin: CGPoint(x: 0.0, y: (self.frame.size.height)-5), size: CGSize(width: self.frame.size.width, height: 5.0))
        self.layer.addSublayer(borderLayer)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    // Deleting drawing regular letters in texfield
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    // Getting empty dotted frame bar
    private func getEmptyBar(inRect rect: CGRect, letterIndex index: Int) -> CAShapeLayer {
        let emptyBarLayer: CAShapeLayer = CAShapeLayer()
        emptyBarLayer.name = String(index)
        emptyBarLayer.frame = rect
        emptyBarLayer.fillColor = UIColor.clear.cgColor
        
        let lineWidth: CGFloat = 2.0
        emptyBarLayer.lineWidth = lineWidth
        emptyBarLayer.strokeColor = UIColor.gray.cgColor
        emptyBarLayer.lineJoin = .round
        
        let barRect = CGRect(origin: CGPoint(x: emptyBarLayer.bounds.origin.x + lineWidth, y: emptyBarLayer.bounds.origin.y + lineWidth), size: CGSize(width: emptyBarLayer.bounds.width - 2 * lineWidth, height: emptyBarLayer.bounds.height - 2 * lineWidth))
        
        emptyBarLayer.path = UIBezierPath(roundedRect: barRect, cornerRadius: rect.height/15).cgPath
        emptyBarLayer.lineDashPattern = [6, 3]
        
        return emptyBarLayer
    }
    
    // Override function for drawing text inside textfield
    override func drawText(in rect: CGRect) {
        
        if lastTexfieldText.count > self.text!.count {
            return
        }
        
        // Number of letters inside textfield
        let lettersInTexfield: CGFloat = CGFloat(self.text!.count)
        
        // Getting id name of layer
        let letterID: String = String(format: "%d", Int(lettersInTexfield))
        
        if !isIdAvailable(letterId: letterID) {
            return
        }
        
        // Space between single letters
        let spaceBetweenLetters: CGFloat = 5.0
        
        // Number of letters inside single line of texfield
        let numberOfLettersInLine: CGFloat = 5.0
        
        // Number of rows in texfield
        let numberOfRows: CGFloat = 2.0
        
        // Single letter size
        let letterSize: CGFloat = (self.frame.width - spaceBetweenLetters * 2) / numberOfLettersInLine
        
        // Space between rows inside textfield
        let letterSpacer: CGFloat = (self.bounds.height - 2 * letterSize) / (numberOfRows + 1)
        
        // Generating rect for bar
        var letterRect: CGRect = CGRect(origin: CGPoint(x: (letterSize + spaceBetweenLetters) * lettersInTexfield, y: letterSpacer), size: CGSize(width: letterSize, height: letterSize))
        
        // Changing position of rect if not fitting in line
        if lettersInTexfield > numberOfLettersInLine - 1 {
            letterRect.origin = CGPoint(x: (letterSize + spaceBetweenLetters) * (lettersInTexfield - numberOfLettersInLine), y: letterSize + letterSpacer * 2)
        }
        
        // Creating and adding empty bar layer
        let emptyLayer = EmptyFieldLayer(ofIndex: Int(lettersInTexfield))
        emptyLayer.frame = letterRect
        
        if lettersInTexfield < numberOfLettersInLine * numberOfRows {
            self.layer.addSublayer(emptyLayer)
        }
        
        if !self.text!.isEmpty {
            
            // Modifing rect for empty bar
            letterRect.origin.x -= (letterSize + spaceBetweenLetters)
            
            // Changing position of rect if not fitting in line
            if lettersInTexfield == numberOfLettersInLine {
                letterRect.origin = CGPoint(x: (letterSize + spaceBetweenLetters) * (lettersInTexfield - 1), y: letterSpacer)
            }
            
            // Creating and adding letter bar layer
            
            let letterLayer = SingleLetterLayer(ofCharacter: self.text!.uppercased().last!, ofLetterID: letterID.uppercased())
            letterLayer.frame = letterRect
            
            self.layer.addSublayer(letterLayer)
            
            // Adding drop animation to bar
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = CGPoint(x: letterLayer.position.x, y: -500)
            animation.toValue = letterLayer.position
            animation.duration = 0.3
            animation.delegate = self
            letterLayer.add(animation, forKey: "basic")
        }
    }
    
    private func isIdAvailable(letterId: String) -> Bool {
        for layer in self.layer.sublayers! {
            if let name = layer.name {
                if name == letterId {
                    return false
                }
            }
        }
        return true
    }
     
    // Shake animation for texfield (if data is inncorrect)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                
                for lay in self.layer.sublayers! {
                    if lay.name == String(range.upperBound) {
                        lay.removeFromSuperlayer()
                    }
                }
            }
        }
        
        lastTexfieldText = self.text!
        
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString.length > 10 {
            shakeTexfield()
        }
        
        return newString.length <= maxLength
    }
}
