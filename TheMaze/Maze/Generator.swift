//
//  Generator.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation
import UIKit

protocol GenerateMazeStrategy {
    // The view in which walls must be generated
    var view : UIViewControllerWithAnimation? { get set }
    
    // Array of barriers
    var barriers: [UIView] { get set }
    
    // generate walls in a view
    func generate() -> Void
}

class Generator {
    var generatorStrategy : GenerateMazeStrategy
    
    init(with generator: GenerateMazeStrategy, in view: UIViewControllerWithAnimation) {
        generatorStrategy = generator
        generatorStrategy.view = view
    }
    
    public func generate() {
        var index = 0
        generatorStrategy.generate()
        
        guard let viewController = generatorStrategy.view?.view else { return }
        
        generatorStrategy.view?.animator = UIDynamicAnimator(referenceView: viewController)
        generatorStrategy.view?.collision.collisionDelegate = self as? UICollisionBehaviorDelegate
        
        for barrier in generatorStrategy.barriers {
            generatorStrategy.view?.collision = UICollisionBehavior(items: [barrier])
            generatorStrategy.view?.collision.addBoundary(withIdentifier: "barrier_\(index)" as NSString, for: UIBezierPath(rect: barrier.frame))
            
            generatorStrategy.view?.animator.addBehavior((generatorStrategy.view?.collision)!)
            
            index = index + 1
        }
        
    }
}
