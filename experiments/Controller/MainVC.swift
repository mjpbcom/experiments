//
//  ViewController.swift
//  experiments
//
//  Created by Mariah Jessica Baysic on 7/12/21.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var highScoreBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    
    let userDefaults = UserDefaults.standard
    let TAPPER_HIGHSCORE = "TAPPER_HIGHSCORE"
    
    var score = 0
    var isStarted = false
    var counter = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayHighScore()
        displayTimer()
        restartBtn.isHidden.toggle()
    }
    
    func computeScore() {
        score += 1
        scoreLbl.text = "\(score)"
    }
    
    func displayHighScore() {
        highScoreBtn.setTitle("High Score: \(getHighScore())", for: .normal)
    }
    
    func displayTimer() {
        timerLbl.text = counter < 10 ? "00:0\(counter)" : "00:\(counter)"
    }
    
    func getHighScore() -> Int {
        return userDefaults.integer(forKey: TAPPER_HIGHSCORE)
    }
    
    func setHighScore(to newHighScore: Int) {
        self.userDefaults.set(newHighScore, forKey: self.TAPPER_HIGHSCORE)
        displayHighScore()
    }

    @IBAction func tapTap(_ sender: UIButton) {
        if isStarted {
            computeScore()
            
            redBtn.isEnabled.toggle()
            blueBtn.isEnabled.toggle()
            
            if self.score > self.getHighScore() {
                self.setHighScore(to: self.score)
            }
        } else {
            isStarted.toggle()
            
            score = 0
            computeScore()
            
            counter = 14
            
            sender.isEnabled = false
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.displayTimer()
                
                if self.counter > 0 {
                    self.counter -= 1
                } else {
                    self.redBtn.isEnabled = false
                    self.blueBtn.isEnabled = false
                    
                    self.redBtn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                    self.blueBtn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                    
                    timer.invalidate()
                    
                    self.restartBtn.isHidden.toggle()
                }
            }
        }
        
        if redBtn.isEnabled {
            self.blueBtn.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            self.redBtn.backgroundColor = .systemRed
        } else {
            self.redBtn.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            self.blueBtn.backgroundColor = .systemBlue
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        self.isStarted.toggle()
        
        self.redBtn.isEnabled.toggle()
        self.blueBtn.isEnabled.toggle()
        
        self.redBtn.backgroundColor = .systemRed
        self.blueBtn.backgroundColor = .systemBlue
        
        self.counter = 15
        self.displayTimer()
        
        scoreLbl.text = "0"
        
        restartBtn.isHidden.toggle()
    }
    
    @IBAction func resetHighScore(_ sender: UIButton) {
        let alert = UIAlertController(title: "Reset High Score", message: "Are you sure you want to reset your high score of \(getHighScore())?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { alert in
            self.setHighScore(to: 0)
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

