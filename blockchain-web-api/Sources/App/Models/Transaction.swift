//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation
import Vapor

final class Transaction : Content {
    
    var from :String
    var to :String
    var amount :Double
    
    init(from :String, to :String, amount :Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}
