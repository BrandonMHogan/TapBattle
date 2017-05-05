//
//  ViewController.swift
//  tapbattle
//
//  Created by Brandon Hogan on 2017-05-05.
//  Copyright © 2017 Brandon Hogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    
    @IBAction func greenViewTapped(_ sender: Any) {
        tapEvent(isGreen: true)
    }
    
    @IBAction func redViewTapped(_ sender: Any) {
        tapEvent(isGreen: false)
    }
    
    var score = 0 {
        didSet {
        }
    }
    
    private var greenScore = 0 {
        didSet {
            greenLabel?.text = "\(greenScore)"
        }
    }
    
    private var redScore = 0 {
        didSet {
            redLabel?.text = "\(redScore)"
        }
    }
    
    private let maxScore = 20;
    private var isPlaying = false;
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenScore = 0;
        redScore = 0;
        
        newGame();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func newGame() {
        score = maxScore / 2
        
        greenLabel.alpha = 1
        redLabel.alpha = 1
        
        UIView.animate(withDuration: 2) { 
            self.greenLabel.alpha = 0
            self.redLabel.alpha = 0
        }
        
        let stepTime: TimeInterval = 0.5
        self.centerLabel.alpha = 1
        
        self.centerLabel.text = "3"
        UIView.animate(withDuration: stepTime, animations: {
            self.centerLabel.alpha = 0
        }, completion: { _ in
            self.centerLabel.alpha = 1
            self.centerLabel.text = "2"
            
            UIView.animate(withDuration: stepTime, animations: {
                self.centerLabel.alpha = 0
            }, completion: { _ in
                self.centerLabel.alpha = 1
                self.centerLabel.text = "1"
                
                UIView.animate(withDuration: stepTime, animations: {
                    self.centerLabel.alpha = 0
                }, completion: { _ in
                    self.centerLabel.alpha = 1
                    self.centerLabel.text = NSLocalizedString("Go!", comment: "")
                    
                    UIView.animate(withDuration: stepTime, animations: {
                        self.centerLabel.alpha = 0
                    }, completion: { _ in
                        self.isPlaying = true
                    })
                })
            })
        })
    }
    
    private func tapEvent(isGreen: Bool) {
        // Ignore clicks if the game is not running
        guard isPlaying else { return }
        
        if isGreen {
            score += 1
        }
        else {
            score -= 1
        }
        
        if score > maxScore {
            print("Green Wins")
            greenScore += 1
            isPlaying = false
            newGame()
        }
        else if score < 0 {
            print("Red Wins")
            redScore += 1
            isPlaying = false
            newGame()
        }
    }
}

