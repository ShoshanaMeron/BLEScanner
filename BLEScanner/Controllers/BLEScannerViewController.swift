//
//  ViewController.swift
//  BLEScanner
//
//  Created by ShoshanaMeron on 14/11/2019.
//  Copyright © 2019 Shoshana Meron. All rights reserved.
//
//

import UIKit
import CoreBluetooth
import RxSwift
import RxCocoa

class BLEScannerViewController: UIViewController {
    
    
    @IBOutlet weak var tblBLEDevices: UITableView!
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private let disposeBag = DisposeBag()
    private let bleDevices: BehaviorRelay<[BLEDevice]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        
        bleDevices.bind(to: tblBLEDevices.rx.items(cellIdentifier: "BLEItemTableViewCell", cellType: BLEItemTableViewCell.self)) { row, model, cell  in
            cell.bleDevice = model
        }.disposed(by: disposeBag)
    }
}

extension BLEScannerViewController: CBPeripheralDelegate, CBCentralManagerDelegate{
    // MARK: -CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            showAlertConnectToBluetooth()
        } else {
            centralManager.scanForPeripherals(withServices: nil,
                                              options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let device = BLEDevice(name: (peripheral.name ?? "No name"), uuid: peripheral.identifier.uuidString)
        bleDevices.accept(bleDevices.value + [device])
    }
    
    func showAlertConnectToBluetooth(){
        let alert = UIAlertController(title: "", message: "Turn on the bluetooth",         preferredStyle: UIAlertController.Style.alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alert.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

