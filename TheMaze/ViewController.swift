//
//  ViewController.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator : UIDynamicAnimator!
    var ball : UIImageView!
    var barriers : [UIView]!
    var collision : UICollisionBehavior!
    var exit : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        // set ball + barriers + exit
        
        collision = UICollisionBehavior(items: [ball])
        collision?.collisionDelegate = self
        for barrier in barriers {
            collision!.addBoundary(withIdentifier: "barrier" as NSString, for: UIBezierPath(rect: barrier.frame))
        }
        collision!.translatesReferenceBoundsIntoBoundary = true
        
        let generator = Generator(with: FirstLevelStrategy(), in: self)
        generator.generate()
    }

    func setBall(x: Int = 50, y: Int = 850, width: Int = 30, height: Int = 30) {
        
    }
    
    //func setExit()
    //func generateBarriers()
    
}

extension ViewController: UICollisionBehaviorDelegate {
    
}
