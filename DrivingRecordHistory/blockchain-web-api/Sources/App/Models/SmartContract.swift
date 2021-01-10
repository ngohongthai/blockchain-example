//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation

class DrivingRecordSmartContract : Codable {
    
    func apply(transaction :Transaction, allBlocks :[Block]) {
        
        allBlocks.forEach { block in
            
            block.transactions.forEach { trans in
                
                if trans.driverLicenseNumber == transaction.driverLicenseNumber {
                    transaction.noOfViolations += 1
                }
                
                if transaction.noOfViolations > 5 {
                    transaction.isDrivingLicenseSuspended = true
                }
                
            }
            
        }
        
    }
    
}

