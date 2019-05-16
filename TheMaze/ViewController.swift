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
    var target : UIView? = nil
    var collision : UICollisionBehavior!
    var current: Int = 0
    var tries = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextLvl.layer.zPosition = 0
        score.layer.zPosition = 1
        setScore()
        
        animator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [])
        collision?.collisionDelegate = self
        collision!.translatesReferenceBoundsIntoBoundary = true

        let strategy = FirstLevelStrategy()
        let generator = Generator(with: strategy, in: self)
        
        generator.generate()
        setBall(x: Int(strategy.startBall.x), y: Int(strategy.startBall.y))
        collision.addItem(ball!)
        
        setTarget(x: Int(strategy.target.x), y: Int(strategy.target.y))
        collision!.addBoundary(withIdentifier: "target" as NSString, for: UIBezierPath(rect: target!.frame))
        collision!.translatesReferenceBoundsIntoBoundary = true
        
        let gravity = UIGravityBehavior(items: [ball!])
        gravity.magnitude = 0.6
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }
    
    func reset() {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setBall(x: Int = 15, y: Int = 850, width: Int = 30, height: Int = 30) {
        let ball = UIView(frame: CGRect(x: x - width / 2, y: y, width: width, height: height))
        ball.backgroundColor = UIColor.gray
        ball.layer.cornerRadius = CGFloat(width / 2)
        
        self.view.addSubview(ball)
        self.ball = ball
    }
    
    func setTarget(x: Int = 15, y: Int, width: Int = 30, height: Int = 30) {
        let target = UIView(frame: CGRect(x: x - width / 2, y: y, width: width, height: height))
        target.backgroundColor = UIColor.purple
        target.layer.cornerRadius = CGFloat(width / 2)
        
        self.view.addSubview(target)
        self.target = target
    }
    
    func gameOver() {
        print("Loser...")
    }
    
    func setScore(_ newScore: Int? = nil) {
        tries = newScore ?? tries - 1
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
    
        var n : Int? = nil
        if let id = identifier as? String,
           id == "target",
           let s = score.text,
           let si = Int(s) {
            n = si + current
            nextLvl.layer.zPosition = 1
        }
        setScore(n)
    }
}
