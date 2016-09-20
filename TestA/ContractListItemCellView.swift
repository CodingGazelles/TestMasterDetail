//
//  ContractListItemCellView.swift
//  TestA
//
//  Created by Tancrède on 9/15/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import UIKit




class ContractListItemCellView: UITableViewCell {
    
    
    
    // Static constants
    static let Identifier = "ContractListItemCellView"
    
    
    
    // Outlets
    @IBOutlet weak var contractNumber: UILabel!
    @IBOutlet weak var contractDate: UILabel!
    @IBOutlet weak var contractValue: UILabel!

    
    
    /*
        Finalizing configuration
    */
    override func awakeFromNib() {
        layoutMargins = UIEdgeInsetsZero
    }
    
}
