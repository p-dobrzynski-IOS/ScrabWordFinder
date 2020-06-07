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
        borderLayer.frame = CGRect(origin: CGPoint(x: 0.0, y: (self.frame.size.height)-1), size: CGSize(width: self.frame.size.width, height: 1.0))
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
        letterLayer.cornerRadius = rect.height / 5
        letterLayer.frame = rect
        letterLayer.opacity = 1.0

        let letterCharLayer = CATextLayer()
        letterCharLayer.string = String(letter)
        letterCharLayer.frame = letterLayer.bounds
        letterCharLayer.fontSize = letterLayer.bounds.height - letterLayer.bounds.height/5
        letterCharLayer.foregroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)?.cgColor
        letterCharLayer.alignmentMode = .center
        letterLayer.addSublayer(letterCharLayer)

        return letterLayer
    }

    override func drawText(in rect: CGRect) {

        if !self.text!.isEmpty {

            let lettersInTexfield: Int = Int(self.text!.count)

            let letterSize: CGFloat = (self.frame.width-4) / 5

            var letterRect: CGRect = CGRect(origin: CGPoint(x: (letterSize+2) * CGFloat(lettersInTexfield - 1), y: 0), size: CGSize(width: letterSize, height: letterSize))

            if (lettersInTexfield % 6) == 0 {
                letterRect.origin = CGPoint(x: (letterSize+2) * CGFloat(lettersInTexfield - 5 - 1), y: letterRect.origin.y + letterSize)
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
