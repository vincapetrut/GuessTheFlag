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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareScore))
        
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
    
    @objc func restartGame() {
        let alertController = UIAlertController(title: "Do you want to restart your game? :)", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) {action in
            self.questionsAsked = 0
            self.currentScore = 0
            self.askQuestion()
        })
        present(alertController, animated: true)
    }
    
    @objc func shareScore() {
        let activityController = UIActivityViewController(activityItems: ["Your correct score is \(currentScore)p"], applicationActivities: [])
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityController, animated: true)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        allFlags.shuffle()
        UIView.transition(with: firstFlag, duration: 0.5, options: .transitionCrossDissolve, animations: {self.firstFlag.setImage(UIImage(named: self.allFlags[0]), for: .normal)}, completion: nil)
        UIView.transition(with: secondFlag, duration: 0.5, options: .transitionCrossDissolve, animations: {self.secondFlag.setImage(UIImage(named: self.allFlags[1]), for: .normal)}, completion: nil)
        UIView.transition(with: thirdFlag, duration: 0.5, options: .transitionCrossDissolve, animations: {self.thirdFlag.setImage(UIImage(named: self.allFlags[2]), for: .normal)}, completion: nil)
        correctAnswer = Int.random(in: 0...2)
        
        questionMessage.text = "Which flag is for \(allFlags[correctAnswer].uppercased())?"
        questionsAsked += 1
    }
}
