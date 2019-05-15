//
//  ViewController.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
import CoreMotion

protocol WithAnimation {
    var animator: UIDynamicAnimator! { get set }
    var collision: UICollisionBehavior! { get set }
}

typealias UIViewControllerWithAnimation = UIViewController & WithAnimation

class ViewController: UIViewControllerWithAnimation {
    
    var animator : UIDynamicAnimator!
    var ball : UIView!
    var collision : UICollisionBehavior!
    var exit : UIView!
    var current: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        // set ball + barriers + exit
        
        collision = UICollisionBehavior(items: [])
        collision?.collisionDelegate = self
        collision!.translatesReferenceBoundsIntoBoundary = true

        let strategy = FirstLevelStrategy()
        
        let generator = Generator(with: strategy, in: self)
        
        setBall(x: Int(strategy.startBall!.x), y: Int(strategy.startBall!.y))
        collision.addItem(ball)
        generator.generate()
    }
    
    func reset() {
        self.ball = nil
    }
    
    func setBall(x: Int = 15, y: Int = 850, width: Int = 30, height: Int = 30) {
        ball = UIView(frame: CGRect(x: x - width / 2, y: y, width: width, height: height))
        ball.contentMode = .scaleAspectFill
        ball.backgroundColor = UIColor.yellow
        ball.layer.cornerRadius = CGFloat(width / 2)
        
        self.view.addSubview(ball)
    }
    
    @IBAction func nextLevel(_ sender: Any) {
        var strategy: [GenerateMazeStrategy] = [FirstLevelStrategy()]
        
        if strategy.indices.contains(current) {
            reset()
            
            // SecondLevelStrategy
        }
        
        self.current = self.current + 1
    }
}

extension ViewController: UICollisionBehaviorDelegate {
    
}
