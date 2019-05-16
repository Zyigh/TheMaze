//
//  FirstLevelGenerator.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation
import UIKit

class FirstLevelStrategy : GenerateMazeStrategy {
    var view : UIViewControllerWithAnimation? = nil
    var barriers = [UIView]()
    var startBall: CGPoint!
    var target: CGPoint!
    
    public func generate() {
        guard let viewController = view else { return }
        startBall = CGPoint(x: viewController.view.frame.midX, y: viewController.view.frame.height - 40)
        target = CGPoint(x: viewController.view.frame.midX, y: 40)

        barriers.append(UIView(frame: CGRect(x: 0, y: 0, width: 150, height: viewController.view.frame.height)))
        barriers.append(UIView(frame: CGRect(x: viewController.view.frame.width - 150, y: 0, width: 150, height: viewController.view.frame.height)))
        
        for barrier in barriers {
            viewController.view.addSubview(barrier)
            barrier.backgroundColor = UIColor.red
        }
    }
}
