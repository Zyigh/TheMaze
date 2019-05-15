//
//  Generator.swift
//  TheMaze
//
//  Created by Hugo Medina on 15/05/2019.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation

protocol IGenerateMaze {
    func generate() -> Void
}

class Generator {
    let generatorStrategy : IGenerateMaze
    
    init(with generator: IGenerateMaze) {
        generatorStrategy = generator
    }
    
    public func generate() {
        generatorStrategy.generate()
    }
}
