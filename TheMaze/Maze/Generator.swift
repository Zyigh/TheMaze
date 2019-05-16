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
    // Set a coord for ball
    var startBall: CGPoint! { get set }
    // Destination
    var target: CGPoint! { get set }
    
    
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
        
        guard let viewController = generatorStrategy.view else { return }
        
        
        for barrier in generatorStrategy.barriers {
            viewController.collision.addItem(barrier)
            viewController
                .collision
                .addBoundary(
                    withIdentifier: "barrier_\(index)" as NSString,
                    for: UIBezierPath(
                        rect: barrier.frame
                    )
                )
            index = index + 1
        }
    }
}
