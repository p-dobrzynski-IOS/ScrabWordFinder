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

    //Background Image
    let backgroundImage = UIImageView(image: UIImage(named: "backgroundPool"))

    // Textfield to enter selected letters
    let lettersTextfield: ScrabTextField = {
        let textfield: ScrabTextField = ScrabTextField()
        //Adding action while editing textfield
        textfield.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        return textfield
    }()

    // Generate Words Button
    let generateButton: UIButton = {
        let button: UIButton = UIButton()
        button.titleLabel?.text = "Calculate"
        button.backgroundColor = .red
        //Adding action on button click
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        return button
    }()
    
    // Info label
    let infoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Use keyboard to enter letters"
        label.textColor = UIColor.white
        return label
    }()

    // Trie algorithm object
    let scrabAlgorithm = ScrableAlgorithm()

    // Words array
    lazy var wordsArray: [String] = [String]()

    // Valid words array
    var validWordsArray: [ValidWords]?

    override func viewDidLoad() {
        super.viewDidLoad()

        //Loading list of words
        wordsArray = loadWordList(fileName: "wordlist")

        self.view.backgroundColor = UIColor(named: Constants.Colors.scrabbleBlockLetterColor)

        //Addding UI elements to view
        setupViews()

//        lettersTextfield.becomeFirstResponder()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        print("WILL SHOW")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("WILL DISAPEAR")
    }

    // Button pressed Event
    @objc private func buttonPressed(sender: UIButton) {

        if let textFieldString: String = lettersTextfield.text {
            if !textFieldString.isEmpty {
                
                let charactersArray: [Character] = Array(textFieldString)
                
                if validateLetters(of: charactersArray) {
                    validWordsArray = scrabAlgorithm.findValidWords(in: wordsArray, with: charactersArray)
                    performSegue(withIdentifier: Constants.EnterToResultSegue, sender: self)
                } else {
                    lettersTextfield.shakeTexfield()
                }
                
            } else {
                lettersTextfield.shakeTexfield()
            }
        }
    }

    // Preparing view controller for seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.EnterToResultSegue {
            let destinationVC = segue.destination as? ResultViewController
            destinationVC!.validWordsArray = validWordsArray
        }
    }
    
    // Checking if letters are correct (included in alphabet array)
    func validateLetters(of lettersArray: [Character]) -> Bool {
        for char in lettersArray {            if !Constants.pointsAlphabet.contains(where: {$0.char == Character(char.uppercased())}) {
            return false
            }
        }
        return true
    }
    
    // Loading words list from file
    func loadWordList(fileName: String) -> [String] {
        var wordDict: [String] = [String]()
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let file = try String(contentsOfFile: filepath)
                wordDict = file.components(separatedBy: "\n")
            } catch let error {
                Swift.print("Fatal Error: \(error.localizedDescription)")
            }
        } else {
            print("not found")
        }
        return wordDict
    }

    // Adding subviews to main view
    private func setupViews() {

        //        self.view.addSubview(backgroundImage)
        //        backgroundImage.snp.makeConstraints { (make) in
        //            make.edges.equalTo(self.view.snp.edges)
        //        }

        // Adding info label
        self.view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(20)
            make.centerX.equalTo(self.view.snp.centerX)
        }

        // Adding textfield to view
        self.view.addSubview(lettersTextfield)
        lettersTextfield.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.frame.height/3)
            make.center.equalTo(self.view.snp.center)
            make.left.equalTo(self.view.snp.leftMargin)
            make.right.equalTo(self.view.snp.rightMargin)
        }

        // Adding button to view
        self.view.addSubview(generateButton)
        generateButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(lettersTextfield.snp.bottom).offset(10)
        }
    }

}
