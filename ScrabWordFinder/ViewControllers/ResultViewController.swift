//
//  ResultViewController.swift
//  ScrabWordFinder
//
//  Created by Piotr on 02/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {
    
    // Tableview declaration
    let pointsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    // ScrollView
    let pointsScrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        return scrollView
    }()
    
    // Initial array of Strings
    var validWordsArray: [ValidWords]!
    
    // Array od words and poitns contatiners
    var viewsContainterArray: [UIStackView] = [UIStackView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)
                
        // Setting arrow as back button
        setCustomNavigationButton()
        
        //Adding subviews to main view
        setupViews()
    }
    
    func getWords(ofIndex points: Int, fromArray validWords: [(word: String, value: Int)]) -> [String] {
        let sameWords: [String] = [String]()
        return sameWords
    }
    
    // Gettiing label with points value
    private func getPointsLabel(ofPoints points: Int) -> UILabel {
        let pointsLabel: UILabel = {
            let label: UILabel = UILabel()
            label.font = .systemFont(ofSize: self.view.frame.width/17)
            label.text = String(format: "%d Points", points)
            label.textColor = UIColor.white
            label.layer.shadowColor = UIColor.black.cgColor
            label.layer.shadowRadius = 2
            label.layer.shadowOpacity = 0.5
            label.layer.shadowOffset = CGSize(width: 2, height: 2)
            label.layer.masksToBounds = false
            return label
        }()
        return pointsLabel
    }
    
    // Adding subviews to main view
    private func setupViews() {
        view.addSubview(pointsScrollView)
                
        pointsScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.leftMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        
        pointsScrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(pointsScrollView.snp.edges)
            make.width.equalToSuperview()
        }
        
        for validWord in validWordsArray {
            
            let subStackView: UIStackView = {
                let stackView: UIStackView = UIStackView()
                stackView.axis = .vertical
                stackView.spacing = 3
                return stackView
            }()
            
            let pointsLabel: UILabel = getPointsLabel(ofPoints: validWord.points)
            
            subStackView.addArrangedSubview(pointsLabel)
            
            let singleWordsStackView: UIStackView = {
                let stackView: UIStackView = UIStackView()
                stackView.axis = .vertical
                stackView.spacing = 3
                return stackView
            }()
            
            for word in validWord.words {
                let label = CorrectWordView(forWord: word)
    
                singleWordsStackView.addArrangedSubview(label)
                
                label.snp.makeConstraints { (make) in
                    make.height.equalTo(self.view.frame.width/10)
                }
            }
            subStackView.addArrangedSubview(singleWordsStackView)
            stackView.addArrangedSubview(subStackView)
        }
    }
}
