//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by tezz on 23/02/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class QuizBrain {
    let questions = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    var progress: Double = 0.0 {
        didSet {
            let userinfo: [String: Double] = ["progress": self.progress]
            NotificationCenter.default.post(Notification(name: .progress, object: nil, userInfo: userinfo))
      }
    }
    var questionNumber = 0
    var score = 0
    
    // Common Functionality
    var cf = CommonFunctionality()
    
    init(progress: Double, questionNumber: Int, cf: CommonFunctionality) {
        self.progress = progress
        self.questionNumber = questionNumber
        self.cf = cf
    }
    
    func checkAnswer(_ sender: UIButton, _ viewController: UIViewController, progressBarHC: inout UIHostingController<LinearProgressView>) {
        cf = CommonFunctionality(viewController)
        
        progress += Double(1) / Double(questions.count)

        if (sender.currentTitle! == questions[questionNumber].a) {
            sender.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
            score += 1
        }
        else {
            sender.backgroundColor = UIColor(red: 0.6, green: 0.0, blue: 0.0, alpha: 1.0)
        }

        progressBarHC.rootView.progress = progress
        progressBarHC.view.updateConstraints()
//        progressBarHC.view!.removeFromSuperview()
//
//        progressBarHC = UIHostingController(rootView: LinearProgressView(width: cf.screenWidth, height: 20.0, progress: progress))
//        let progressBarHCALC = AutoLayoutConstraints(subView: progressBarHC.view!, width: cf.screenWidth, height: cf.screenHeight / 10, yOffset: cf.screenHeight / 25, yCentered: false, yTop: false)
//        cf.setSwiftUIView(progressBarHC, viewController, progressBarHCALC)
        
        questionNumber += 1
    }
}

extension Notification.Name {
  static var progress: Notification.Name { return .init("progress") }
}
