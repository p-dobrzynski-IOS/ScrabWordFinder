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
        label.textColor = UIColor.white
        return label
    }()
    
    let pointsValueLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Points"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 40)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.25
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.masksToBounds = false
        return label
    }()
    
    let mainStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
//        stackView.spacing = 20
        stackView.distribution = .fill
        return stackView
    }()
    
    let wordsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding words to stackview
    private func addWords(wordsArray: [String]) {
        
        let wordView: CorrectWordView = CorrectWordView(forWord: "DUPA")
        wordsStackView.addArrangedSubview(wordView)
        wordView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView)
        }
        
//        for word in wordsArray {
//
//            let tempView = UIView()
//            tempView.backgroundColor = .red
//            tempView.frame.size.height = 50
//            let wordView: CorrectWordView = CorrectWordView(forWord: word)
//
//            var newFrame = wordView.frame
//
//            wordsStackView.addArrangedSubview(wordView)
//
//
//            wordView.snp.makeConstraints { (make) in
//                make.height.equalTo(60)
//                make.left.equalTo(self.contentView.snp.left)
//                make.right.equalTo(self.contentView.snp.right)
//            }
//        }
    }
    
    // Adding subviews to cell view
    private func setupViews() {
        
        self.contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView.snp.edges)
//                        make.left.equalTo(self.contentView.snp.leftMargin)
//                        make.top.equalTo(self.contentView.snp.top).offset(10)
//                        make.right.equalTo(self.contentView.snp.rightMargin)
//                        make.bottom.equalTo(self.contentView.snp.bottom).offset(-25)
        }
        
        mainStackView.addArrangedSubview(pointsValueLabel)
        pointsValueLabel.snp.makeConstraints { (make) in
            make.height.equalTo(75)
        }
        
        mainStackView.addArrangedSubview(wordsStackView)
        
    }
    
}
