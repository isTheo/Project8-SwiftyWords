//
//  ViewController.swift
//  Project8-SwiftyWords
//
//  Created by Matteo Orru on 26/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    
    override func loadView() {
 
        view = UIView()
        view.backgroundColor = UIColor(red: 1/255, green: 21/255, blue: 36/255, alpha: 1.0)

            
        //set positioning, text, font and colors of scoreLabel
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont(name: "Supercell-Magic", size: 30.0)
        scoreLabel.textColor = UIColor(red: 255/255, green: 236/255, blue: 209/255, alpha: 1.0)
        view.addSubview(scoreLabel)
            
        //set cluesLabel
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = "CLUES"
        cluesLabel.font = UIFont(name: "Supercell-Magic", size: 20.0)
        cluesLabel.textColor = UIColor(red: 233/255, green: 114/255, blue: 76/255, alpha: 1.0)
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
            
        //set answersLabel
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.textAlignment = .right
        answersLabel.text = "ANSWERS"
        answersLabel.font = UIFont(name: "Supercell-Magic", size: 20.0)
        answersLabel.textColor = UIColor(red: 255/255, green: 125/255, blue: 0/255, alpha: 1.0)
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
            
        //set currentAnswer
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont(name: "Supercell-Magic", size: 22.0)
        currentAnswer.textColor = UIColor(red: 255/255, green: 125/255, blue: 0/255, alpha: 1.0)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
            
        //set UIButtons submit and clear
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.titleLabel?.font = UIFont(name: "Supercell-Magic", size: 20.0)
        submit.setTitleColor(UIColor(red: 21/255, green: 97/255, blue: 179/255, alpha: 1.0), for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
            
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.titleLabel?.font = UIFont(name: "Supercell-Magic", size: 20.0)
        clear.setTitleColor(UIColor(red: 21/255, green: 97/255, blue: 179/255, alpha: 1.0), for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
            
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 8.0
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
            
        //set labels and buttons constraints
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                
            //pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 15),
                
            //pin the leading edge of the clues label to the leading edge of our layour margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                
            //make the clues label 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
                
            //also pin the top of the answers lael to the bottom of the score label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 15),
                
            //make the answers label stick to the trailing edge of our layour margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                
            //make the answers label take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
                
            //make the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
                
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
                
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
                
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
                
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
                
        ])
            
        //set values for the width and height of each button
        let width = 150
        let height = 80
            
        //create 20 buttons as a 4x5 grid
        for row in 0..<4 {
            for column in 0..<5 {
                //create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont(name: "Supercell-Magic", size: 20.0)
                letterButton.layer.borderWidth = 1.0
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.setTitleColor(UIColor(red: 255/255, green: 200/255, blue: 87/255, alpha: 1.0), for: .normal)
                    
                //calculate the framse of this button using its column and row
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                    
                //add it to the buttons view
                buttonsView.addSubview(letterButton)
                    
                //also append it to our letterButtons array
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            }
        }
        
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
    
    
    
    //buttons logic
    @objc func letterTapped(_ sender: UIButton) {
        
        //adds a safety check to read the title from the tapped button, or exit if it didn't have one for some reason
        guard let buttonTitle = sender.titleLabel?.text else {return}
        //appends taht button title to the player's current answer
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        //appends the button to the activatedButtons array
        activatedButtons.append(sender)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            sender.alpha = 0
        }
    }
    
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else {return}
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go.", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let errorController = UIAlertController(title: "Wrong move!", message: "This is not the answer.", preferredStyle: .alert)
            errorController.addAction(UIAlertAction(title: "Ok", style: .default))
            present(errorController, animated: true)
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                btn.alpha = 1
            }
        }
        //activatedButtons.removeAll()
    }
    
    
    //load and parse our level text file in the correct format and randomly assign letter groups to buttons
    func loadLevel() {
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        //find and load the level string from our app bundle
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                //Using enumerated() to obtain oth the line element and its position(index) in the "lines" array. For each line, extracts two parts separated by a colon and a space, the first part represents the answer, the second the clue.
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    //takes the position of each clue and adds 1 (starting from 1), combines this number with the actual clue text, each line in the list looks like "clue number.clue" with a new line after each
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "") //replacing instances of | with an empty string
                    solutionString += "\(solutionWord.count) letters \n"
                    solutions.append(solutionWord)
                    
                    let bits =  answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
            cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
            letterBits.shuffle()
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
        
    }
    
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.alpha = 1
        }
    }



}

