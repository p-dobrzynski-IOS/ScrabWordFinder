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
        for word in wordsArray {
            let wordLabel: UILabel = UILabel()
            wordLabel.text = word
            wordsStackView.addArrangedSubview(wordLabel)
        }
    }

    // Adding subviews to cell view
    private func setupViews() {
        self.contentView.addSubview(pointsValueLabel)
        pointsValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
        }

        self.contentView.addSubview(wordsStackView)
        wordsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(pointsValueLabel.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
        }
    }

}
