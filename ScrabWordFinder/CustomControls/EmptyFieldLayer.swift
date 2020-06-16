//
//  EmptyField.swift
//  ScrabWordFinder
//
//  Created by Piotr on 15/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import Foundation
import UIKit

class EmptyFieldLayer: CAShapeLayer {

    var layerRect: CGRect = .zero

    init(inRect rect: CGRect) {
        super.init()
        layerRect = rect

        setupLayer()
    }

    init(inRect rect: CGRect, ofIndex index: Int) {
        super.init()
        layerRect = rect

        self.name = String(index)

        setupLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayer() {
        self.frame = layerRect
        self.fillColor = UIColor.clear.cgColor

        let lineWidth: CGFloat = 2.0
        self.lineWidth = lineWidth
        self.strokeColor = UIColor.gray.cgColor
        self.lineJoin = .round

        let barRect = CGRect(origin: CGPoint(x: self.bounds.origin.x + lineWidth, y: self.bounds.origin.y + lineWidth), size: CGSize(width: self.bounds.width - 2 * lineWidth, height: self.bounds.height - 2 * lineWidth))

        self.path = UIBezierPath(roundedRect: barRect, cornerRadius: layerRect.height/15).cgPath
        self.lineDashPattern = [6, 3]
    }
}
