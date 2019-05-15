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
    var view : UIViewController? { get set }
    // generate walls in a view
    func generate() -> Void
}

class Generator {
    var generatorStrategy : GenerateMazeStrategy
    
    init(with generator: GenerateMazeStrategy, in view: UIViewController) {
        generatorStrategy = generator
        generatorStrategy.view = view
    }
    
    public func generate() {
        generatorStrategy.generate()
    }
}
