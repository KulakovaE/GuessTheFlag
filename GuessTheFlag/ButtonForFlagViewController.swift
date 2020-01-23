//
//  ButtonForFlagViewController.swift
//  GuessTheFlag
//
//  Created by Elena Kulakova on 2020-01-23.
//  Copyright © 2020 Elena Kulakova. All rights reserved.
//

import UIKit

class ButtonForFlagViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion(action: nil)
        borderConfigurationForBtn()
    }
    
    func askQuestion(action: UIAlertAction!) {
        stackView.alpha = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Find the \(countries[correctAnswer].uppercased()) flag"
        scoreLabel.text = "Your score is: \(score)"
        
        if counter == 10 {
            let ac = UIAlertController(title: "Game Over", message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            counter = 0
        }
        counter += 1
        
        UIView.animate(withDuration: 1) {
            self.stackView.alpha = 1
        }
    }
    
    func borderConfigurationForBtn() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
}
