//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

// MVC Design Pattern - to reduce code complexity and organize code.

import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    var questionNumber = 0
    
    var questionLabel = UILabel()
    var titleLabel = UILabel()
    var footNoteLabel = UILabel()
    var trueButton = UIButton()
    var falseButton = UIButton()
    var bubblesImageView = UIImageView(image: UIImage(imageLiteralResourceName: "Background-Bubbles"))
    var answer = true
    var progress = 0.0
    var cf = CommonFunctionality()
    var quizBrain = QuizBrain(progress: 0.0, questionNumber: 0, cf: CommonFunctionality())
    
    var progressBarHC = UIHostingController(rootView: LinearProgressView(progress: 0.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cf = CommonFunctionality(self)
        quizBrain = QuizBrain(progress: 0.0, questionNumber: 0, cf: cf)
        
        let bubblesImageViewALC = AutoLayoutConstraints(subView: bubblesImageView, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8, yCentered: false, yTop: false)
        self.view.addSubview(bubblesImageView)
        bubblesImageViewALC.setAutoConstraints(self)
        
        let screenWidth = view.safeAreaLayoutGuide.layoutFrame.width - 32
        let screenHeight = view.safeAreaLayoutGuide.layoutFrame.height - 32
        
        cf.setLabel(titleLabel, as: "quizzy", of: .clear, with: 10, in: self, AutoLayoutConstraints(subView: titleLabel, width: screenWidth, height: screenHeight / 8, yCentered: false), textAlignment: .right)
        
        cf.setLabel(questionLabel, as: quizBrain.questions[quizBrain.questionNumber].q, of: .clear, with: 15, in: self, AutoLayoutConstraints(subView: questionLabel, width: screenWidth, height: screenHeight / 2, yOffset: screenHeight / 8, yCentered: false), textAlignment: .left)
        
        
        cf.setLabel(footNoteLabel, as: "made by tezz-io", of: .clear, with: 15, in: self, AutoLayoutConstraints(subView: footNoteLabel, width: screenWidth, height: screenHeight / 15, yCentered: false, yTop: false), textAlignment: .center)
        
        cf.setButton(trueButton, as: "True", of: .clear, with: 15, in: self, AutoLayoutConstraints(subView: trueButton, width: screenWidth * 0.9, height: screenHeight / 10, yOffset: screenHeight / 7 + screenHeight / 10 + 15, yCentered: false, yTop: false))
        trueButton.addTarget(self, action: #selector(answerButtonPressed(_:)), for: .touchUpInside)
        
        cf.setButton(falseButton, as: "False", of: .clear, with: 15, in: self, AutoLayoutConstraints(subView: falseButton, width: screenWidth * 0.9, height: screenHeight / 10, yOffset: screenHeight / 7, yCentered: false, yTop: false))
        falseButton.addTarget(self, action: #selector(answerButtonPressed(_:)), for: .touchUpInside)
        
        progressBarHC = UIHostingController(rootView: LinearProgressView(width: screenWidth, height: 20.0, progress: progress))
        let progressBarHCALC = AutoLayoutConstraints(subView: progressBarHC.view!, width: screenWidth, height: screenHeight / 10, yOffset: screenHeight / 25, yCentered: false, yTop: false)
        cf.setSwiftUIView(progressBarHC, self, progressBarHCALC)
        
    }
    
    @objc func answerButtonPressed(_ sender: UIButton) {
        
        quizBrain.checkAnswer(sender, self, progressBarHC: &progressBarHC)
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
            self.trueButton.backgroundColor = .clear
            self.falseButton.backgroundColor = .clear
        })
        
        if quizBrain.questionNumber <= quizBrain.questions.count - 1 {
            self.questionLabel.text = quizBrain.questions[quizBrain.questionNumber].q
        }
        else {
            if quizBrain.score >= quizBrain.questions.count {
                self.questionLabel.text = "Congrats! You have passed the quiz!\n\n Your score: \(quizBrain.score)/\(quizBrain.questions.count)"
            }
            else {
                self.questionLabel.text = "Aww No! You have failed the quiz!\n\n Your score: \(quizBrain.score)/\(quizBrain.questions.count)"
            }
            self.trueButton.removeFromSuperview()
            self.falseButton.removeFromSuperview()
            self.progressBarHC.view!.removeFromSuperview()
        }
    }
}


