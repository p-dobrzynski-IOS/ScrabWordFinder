//
//  ResultViewController.swift
//  ScrabWordFinder
//
//  Created by Piotr on 02/06/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Tableview declaration
    let pointsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = 500
        return tableView
    }()

    // Initial array of Strings
    var validWordsArray: [ValidWords]!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(validWordsArray!)

        pointsTableView.register(PointsTableViewCell.self, forCellReuseIdentifier: "cell")

        pointsTableView.delegate = self
        pointsTableView.dataSource = self

        //Adding subviews to main view
        setupViews()
    }

    func getWords(ofIndex points: Int, fromArray validWords: [(word: String, value: Int)]) -> [String] {

        let sameWords: [String] = [String]()

        return sameWords
    }
    
    // Adding subviews to main view
    private func setupViews() {
        self.view.addSubview(pointsTableView)
        pointsTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validWordsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PointsTableViewCell
        cell?.words = validWordsArray[indexPath.row].words
        cell?.points = validWordsArray[indexPath.row].points
        cell?.letters = validWordsArray[indexPath.row].letters
        tableView.beginUpdates()
        tableView.endUpdates()
        return cell!
    }
}
