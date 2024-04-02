//
//  ArchitectureConfig.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/04/24.
//

import Foundation

protocol ArchitectureConfig: AnyObject {
    func startMVVMC()
    func startVIP()
    func startVIPER()
}

enum ArchitectureType {
    case mvvmc, vip, viper
}
