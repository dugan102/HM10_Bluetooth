//
//  BluetoothViewModel.swift
//  HM10 CoreBluetooth
//
//  Created by Jackson Dugan on 7/7/24
import Foundation
import CoreBluetooth
import Combine

class BluetoothManager: NSObject, ObservableObject {
    private var centralManager: CBCentralManager!
    @Published var discoveredPeripherals: [Peripheral] = [] // Updated to be @Published
    @Published var connectedPeripheral: Peripheral?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func stopScanning() {
        centralManager.stopScan()
    }

    func connect(to peripheral: Peripheral) {
        centralManager.connect(peripheral.peripheral, options: nil)
    }

    func disconnect() {
        if let connectedPeripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(connectedPeripheral.peripheral)
        }
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScanning()
        } else {
            // Handle other states (e.g., poweredOff, unsupported)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Check if the peripheral is already in the list
        if !discoveredPeripherals.contains(where: { $0.id == peripheral.identifier }) {
            let newPeripheral = Peripheral(peripheral: peripheral)
            newPeripheral.update(with: advertisementData, rssi: RSSI)
            discoveredPeripherals.append(newPeripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if let index = discoveredPeripherals.firstIndex(where: { $0.id == peripheral.identifier }) {
            connectedPeripheral = discoveredPeripherals[index]
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectedPeripheral = nil
        // Optionally handle reconnection or cleanup here
    }
}

