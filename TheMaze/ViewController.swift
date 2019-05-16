//
//  ViewController.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
import CoreMotion

typealias UIViewControllerWithAnimation = UIViewController & WithAnimation

protocol WithAnimation {
    var animator: UIDynamicAnimator! { get set }
    var collision: UICollisionBehavior! { get set }
}

class ViewController: UIViewController, WithAnimation {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var nextLvl: UIButton!
    var animator : UIDynamicAnimator!
    var ball : UIView? = nil
    var collision : UICollisionBehavior!
    var current: Int = 0
    var tries = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nextLvl.layer.zPosition = 1
        
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [])
        collision?.collisionDelegate = self
        collision!.translatesReferenceBoundsIntoBoundary = true

        let strategy = FirstLevelStrategy()
        let generator = Generator(with: strategy, in: self)
        
        generator.generate()
        setBall(x: Int(strategy.startBall.x), y: Int(strategy.startBall.y))
        collision.addItem(ball!)
    }
    
    func reset() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setBall(x: Int = 15, y: Int = 850, width: Int = 30, height: Int = 30) {
        let ball = UIView(frame: CGRect(x: x - width / 2, y: y, width: width, height: height))
        ball.contentMode = .scaleAspectFill
        ball.backgroundColor = UIColor.gray
        ball.layer.cornerRadius = CGFloat(width / 2)
        
        self.view.addSubview(ball)
        self.ball = ball
    }
    
    func gameOver() {
        print("Loser...")
    }
    
    func setScore() {
        tries = tries - 1
        if tries == 0 {
            gameOver()
        } else {
            score.text = "\(tries)"
        }
    }
    
    @IBAction func nextLevel(_ sender: Any) {
        reset()
        let strategy: [GenerateMazeStrategy] = [FirstLevelStrategy()]
        
        if strategy.indices.contains(current) {
            reset()
            
            // SecondLevelStrategy
        }
        
        self.current = self.current + 1
    }
}

extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
    
        setScore()
        
    }
}
