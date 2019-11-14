//
//  BLEItemTableViewCell.swift
//  BLEScanner
//
//  Created by ShoshanaMeron on 14/11/2019.
//  Copyright © 2019 Shoshana Meron. All rights reserved.
//

import UIKit

class BLEItemTableViewCell: UITableViewCell {

    var bleDevice: BLEDevice! {
        didSet {
            configure(bleDevice: bleDevice)
        }
    }
    @IBOutlet weak var lblBLEName: UILabel!
    
    @IBOutlet weak var lblBLEUUid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblBLEUUid.adjustsFontSizeToFitWidth = true
        lblBLEUUid.minimumScaleFactor = 0.2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    func configure(bleDevice:BLEDevice)
    {
        lblBLEName.text = bleDevice.name
        lblBLEUUid.text = bleDevice.uuid
    }

}
