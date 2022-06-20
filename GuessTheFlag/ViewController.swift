//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Petruț Vinca on 20.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var questionMessage: UILabel!
    @IBOutlet var firstFlag: UIButton!
    @IBOutlet var secondFlag: UIButton!
    @IBOutlet var thirdFlag: UIButton!
    var allFlags = [String]()
    var correctAnswer = 0
    var questionsAsked = 0
    var currentScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameTitle.text = "Guess The Flag"
        
        allFlags += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        firstFlag.layer.borderWidth = 1
        secondFlag.layer.borderWidth = 1
        thirdFlag.layer.borderWidth = 1
        firstFlag.layer.borderColor = UIColor.lightGray.cgColor
        secondFlag.layer.borderColor = UIColor.lightGray.cgColor
        thirdFlag.layer.borderColor = UIColor.lightGray.cgColor
        firstFlag.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        secondFlag.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        thirdFlag.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var custom: String
        
        if sender.tag == correctAnswer {
            custom = "Correct :)"
            currentScore += 1
        } else {
            custom = "Wrong, that's the flag of \(allFlags[sender.tag].uppercased()) :("
            currentScore -= 1
        }
        
        if questionsAsked < 10 {
            let alertController = UIAlertController(title: custom, message: "Your current score is \(currentScore)p", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "End :)", message: "Your final score is \(currentScore)p", preferredStyle: .alert)
            present(alertController, animated: true)
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        allFlags.shuffle()
        firstFlag.setImage(UIImage(named: allFlags[0]), for: .normal)
        secondFlag.setImage(UIImage(named: allFlags[1]), for: .normal)
        thirdFlag.setImage(UIImage(named: allFlags[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        questionMessage.text = "Which flag is for \(allFlags[correctAnswer].uppercased())?"
        questionsAsked += 1
    }
}
