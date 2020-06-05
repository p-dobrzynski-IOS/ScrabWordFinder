//
//  ViewController.swift
//  ScrabWordFinder
//
//  Created by Piotr on 29/05/2020.
//  Copyright © 2020 Piotr. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // Textfield to enter selected letters
    lazy var lettersTextfield: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.placeholder = "Enter letters"
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.autocorrectionType = .no
        return textfield
    }()

    // Generate Words Button
    lazy var generateButton: UIButton = {
        let button: UIButton = UIButton()
        button.titleLabel?.text = "Calculate"
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    // Trie algorithm object
    let scrabAlgorithm = ScrableAlgorithm()

    // Words array
    lazy var wordsArray: [String] = [String]()

    // Valid words array
    var validWordsArray: [(points: Int, words: [String])]?

    lazy var sampleLetter: SingleLetter = SingleLetter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sampleLetter.setCharacter(letterCharacter: "W")

        //Addding UI elements to view
        setupViews()

        //Loading list of words
        loadWordList(fileName: "wordlist")

        self.view.backgroundColor = .green

        //Adding action while editing textfield
        lettersTextfield.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)

    }

    @objc func myTextFieldDidChange(_ textField: UITextField) {

    }

    // Button pressed Event
    @objc private func buttonPressed(sender: UIButton) {

        if let textFieldString: String = lettersTextfield.text {
            if !textFieldString.isEmpty {
                validWordsArray = scrabAlgorithm.findValidWords(in: wordsArray, with: Array(textFieldString))
                performSegue(withIdentifier: Constants.mainToResultSegue, sender: self)
            } else {
                print("Empty textfield")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.mainToResultSegue {
            let destinationVC = segue.destination as? ResultViewController
            destinationVC!.validWordsArray = validWordsArray
        }
    }

    // Loading words list from file
    private func loadWordList(fileName: String) {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let file = try String(contentsOfFile: filepath)
                wordsArray = file.components(separatedBy: "\n")
            } catch let error {
                Swift.print("Fatal Error: \(error.localizedDescription)")
            }
        } else {
            print("not found")
        }
    }

    // Adding subviews to main view
    private func setupViews() {
        self.view.addSubview(lettersTextfield)
        lettersTextfield.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.center.equalTo(self.view.snp.center)
        }

//        self.view.addSubview(sampleLetter)
//        sampleLetter.snp.makeConstraints { (make) in
//            make.width.equalTo(50)
//            make.height.equalTo(50)
//            make.center.equalTo(self.view.snp.center)
//        }

        self.view.addSubview(generateButton)
        generateButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(100)
        }

    }

}
