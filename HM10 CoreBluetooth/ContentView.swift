//
//  ContentView.swift
//  HM10 CoreBluetooth
//
//  Created by Jackson Dugan on 7/6/24.


import SwiftUI
import CoreBluetooth

struct ContentView: View {
    var body: some View {
        BluetoothContextView()
    }
    
    //if Bluetooth device connected:
    /*
     go to a new page that has a disconnect button
     
     disconnect button code:
        if clicked, disconnect and go back to start page
     
     forward button:
        sends a 1 to the connected peripheral
     
     backwards button:
        sends a 0 to the connected peripheral
     
     
     this could be called connectedview, and be constructed in a different file for cleaner code.
     
     */
}

struct BluetoothContextView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var selectedPeripheral: Peripheral?

    var body: some View {
        NavigationView {
            VStack {
                if bluetoothManager.discoveredPeripherals.isEmpty {
                    Text("No devices found")
                } else {
                    List {
                        ForEach(bluetoothManager.discoveredPeripherals) { peripheral in
                            Button(action: {
                                selectedPeripheral = peripheral
                                connect(to: peripheral)
                            }) {
                                Text(peripheral.name ?? "Unknown")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Bluetooth Devices")
        }
    }

    private func connect(to peripheral: Peripheral) {
        // Implement connection logic here
        // For demonstration, you can implement connection handling in BluetoothManager or here directly.
        // Example:
        bluetoothManager.connect(to: peripheral)
    }
}

struct BluetoothContextView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothContextView()
    }
}
