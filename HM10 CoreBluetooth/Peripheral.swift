//
//  Peripheral.swift
//  HM10 CoreBluetooth
//
//  Created by Jackson Dugan on 7/8/24.
//

import Foundation
import CoreBluetooth

class Peripheral: NSObject, Identifiable {
    let id: UUID
    let peripheral: CBPeripheral
    @Published var name: String?
    @Published var rssi: NSNumber?

    init(peripheral: CBPeripheral) {
        self.id = peripheral.identifier
        self.peripheral = peripheral
        super.init()
        self.name = peripheral.name
    }

    func update(with advertisementData: [String : Any], rssi: NSNumber) {
        // Update properties based on advertisement data and RSSI
        self.rssi = rssi
        // You can parse additional advertisement data here if needed
    }
}
