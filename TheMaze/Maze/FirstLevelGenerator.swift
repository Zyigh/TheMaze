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
    
    public func generate() {
        guard let viewController = view else { return }

        barriers.append(UIView(frame: CGRect(x: 0, y: 0, width: 150, height: viewController.view.frame.height)))
        barriers.append(UIView(frame: CGRect(x: viewController.view.frame.width - 150, y: 0, width: 150, height: viewController.view.frame.height)))
        
        for barrier in barriers {
            viewController.view.addSubview(barrier)
        }
    }
}
