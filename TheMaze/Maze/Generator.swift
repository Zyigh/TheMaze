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
    var view : UIView { get set }
    // generate walls in a view
    func generate() -> Void
}

class Generator {
    let generatorStrategy : GenerateMazeStrategy
    
    init(with generator: GenerateMazeStrategy, in view: UIView) {
        generatorStrategy = generator
    }
    
    public func generate() {
        generatorStrategy.generate()
    }
}
