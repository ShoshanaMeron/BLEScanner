//
//  BLEDevice.swift
//  BLEScanner
//
//  Created by ShoshanaMeron on 14/11/2019.
//  Copyright © 2019 Shoshana Meron. All rights reserved.
//

import UIKit

struct BLEDevice {
    var name:String?
    var uuid:String?
    
    init(name:String,uuid:String) {
        self.name = name
        self.uuid = uuid
    }
    
}
