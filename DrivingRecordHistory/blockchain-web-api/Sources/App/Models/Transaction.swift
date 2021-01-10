//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation
import Vapor

final class Transaction : Content {
    
    var driverLicenseNumber :String
    var violationType :String
    var noOfViolations :Int = 1
    var isDrivingLicenseSuspended :Bool = false
    
    init(licenseNoHash :String, voilationType :String) {
        self.driverLicenseNumber = licenseNoHash
        self.violationType = voilationType
    }
    
    init?(request :Request) {
        guard let driverLicenseNumber = try? request.content.get(String.self, at: "driverLicense"),
              let violationType = try? request.content.get(String.self, at: "voilationType") else {
            return nil
        }
        
        self.driverLicenseNumber = driverLicenseNumber.sha1Hash()
        self.violationType = violationType
    }
}
