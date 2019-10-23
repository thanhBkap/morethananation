//
//  ViewController.swift
//  MoreThanAFlag
//
//  Created by nguyenthanh on 10/24/19.
//  Copyright © 2019 nguyenthanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var flag1Button: UIButton!
  @IBOutlet weak var flag2Button: UIButton!
  @IBOutlet weak var flag3Button: UIButton!
  
  private var countries = [String]()
  private var score = 0
  private var correctAnswer = 0
  private var numOfQuestion = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    askQuestion(action: nil)
    setupUI()
  }

  @IBAction func tapButton1(_ sender: UIButton) {
    checkAnswer(from: sender)
  }
  
  @IBAction func tapButton2(_ sender: UIButton) {
    checkAnswer(from: sender)
  }
  
  @IBAction func tapButton3(_ sender: UIButton) {
     checkAnswer(from: sender)
  }
  
  func checkAnswer(from button: UIButton) {
    if button.tag == correctAnswer {
      score = score + 1
      next(action: nil)
    }else {
      score = (score == 0) ? 0 : (score - 1)
      let alertVC = UIAlertController(title: "OMG", message: "Wrong! That flag is of \(countries[button.tag].uppercased())", preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: next))
      present(alertVC, animated: true, completion: nil)
    }
   
  }
  
  func next(action: UIAlertAction?) {
    updateScore()
    numOfQuestion = numOfQuestion + 1
    if numOfQuestion == 10 {
      showFinalAlert()
    }else {
      askQuestion(action: nil)
    }
  }
  
  func showFinalAlert() {
    //let title = statusAnswer ? "The answer is correct" : "The answer is wrong"
        let title = "Your Result"
        let alertVC = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: reset))
        present(alertVC, animated: true, completion: nil)
  }
  
  func askQuestion(action: UIAlertAction?) {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    title = countries[correctAnswer].uppercased()
        
    flag1Button.setImage(UIImage(named: countries[0]), for: .normal)
    flag1Button.tag = 0
    flag2Button.setImage(UIImage(named: countries[1]), for: .normal)
    flag2Button.tag = 1
    flag3Button.setImage(UIImage(named: countries[2]), for: .normal)
    flag3Button.tag = 2
  }

  func setupUI() {
    flag1Button.layer.borderWidth = 1
    flag2Button.layer.borderWidth = 1
    flag3Button.layer.borderWidth = 1
    
    flag1Button.layer.borderColor = UIColor.lightGray.cgColor
    flag2Button.layer.borderColor = UIColor.lightGray.cgColor
    flag3Button.layer.borderColor = UIColor.lightGray.cgColor
    
    navigationItem.rightBarButtonItem?.tintColor = .darkGray
    updateScore()
  }
  
  func updateScore() {
    navigationItem.rightBarButtonItem?.title = "Score: \(score)"
  }
  
  func reset(action: UIAlertAction?) {
    numOfQuestion = 1
    score = 0
    updateScore()
    askQuestion(action: nil)
  }
}

