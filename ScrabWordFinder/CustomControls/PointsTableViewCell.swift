//
//  PointsTableViewCell.swift
//  ScrabWordFinder
//
//  Created by Piotr on 04/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import SnapKit

class PointsTableViewCell: UITableViewCell {

    var letters: [Character]? {
        didSet {
            lettersLabel.text = String(letters!).uppercased()
        }
    }

    var points: Int? {
        didSet {
            pointsValueLabel.text = String(format: "%d Points", points!)
        }
    }

    var words: [String]? {
        didSet {
            addWords(wordsArray: words!)
        }
    }

    let lettersLabel: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()

    let pointsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Points"
        return label
    }()

    let wordsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Adding words to stackview
    private func addWords(wordsArray: [String]) {

        let spacer = self.frame.width / 12

        for (wordIndex, word) in wordsArray.enumerated() {

            let wordView: UIView = UIView()

            wordsStackView.addArrangedSubview(wordView)

            wordView.snp.makeConstraints { (make) in
                make.height.equalTo(64)
                make.width.equalTo(self.snp.width)
            }

            for (charIndex, char) in word.enumerated() {
//                let tempLayer = CALayer()
                let tempLayer = SingleLetter(inRect: CGRect(x: 64*charIndex, y: 0, width: 20, height: 20), ofCharacter: "W")
                tempLayer.frame = CGRect(x: 64*charIndex, y: 0, width: 20, height: 20)
//                tempLayer.backgroundColor = UIColor.green.cgColor
                wordView.layer.addSublayer(tempLayer)
            }
//            wordView.backgroundColor = UIColor.red
//            for (charIndex, char) in word.enumerated() {
//                let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 1000, height: 1000))
//                let letterLayer = SingleLetter(inRect: rect, ofCharacter: char)
//
//                letterLayer.backgroundColor = UIColor.black.cgColor
//                wordView.layer.insertSublayer(letterLayer, at: 3)
//            }
//            let letterLayer = SingleLetter(inRect: CGRect(x: 0.0, y: 0.0, width: 500, height: 54), ofCharacter: "W")


        }
    }

    // Adding subviews to cell view
    private func setupViews() {

        self.contentView.addSubview(lettersLabel)
        lettersLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.top.equalTo(self.contentView.snp.topMargin)
        }

        self.contentView.addSubview(pointsValueLabel)
        pointsValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.topMargin)
            make.left.equalTo(self.lettersLabel.snp.right).offset(15)
        }

        self.contentView.addSubview(wordsStackView)
        wordsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(pointsValueLabel.snp.bottom)
            make.left.equalTo(self.contentView.snp.leftMargin)
        }
    }

}
