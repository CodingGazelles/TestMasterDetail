//
//  ContractController.swift
//  TestA
//
//  Created by Tancrède on 9/15/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import UIKit
import ReSwift
import MRProgress



class FOContractController: UIViewController {
    
    
    // Outlets Views
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var spacer1View: UIView!
    @IBOutlet weak var contractValue: UILabel!
    
    
    // Outlets Labels
    @IBOutlet weak var contractNumber: UILabel!
    @IBOutlet weak var contractDate: UILabel!
    @IBOutlet weak var addressPostalCode: UILabel!
    @IBOutlet weak var addressStreetAndPostalCode: UILabel!
    @IBOutlet weak var district: UILabel!
    @IBOutlet weak var cityAndState: UILabel!
    
    
    // Static constants
    static let Identifier = "FOContractController"
    
    
    // Border color
    let borderColor = UIColor(red: 21/255, green: 140/255, blue: 207/255, alpha: 1).CGColor
    
    
    
    // State of the application
    let store = FOStore.defaultStore()
    var state: FOAppState!
    
    
    
    /*
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Connection to the store
        state = store.state
        
        
        // Progress
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true)
        
        
    }
    
    
    
    /*
     Subscribes to AppState modifications
     */
    override func viewWillAppear( animated: Bool) {
        super.viewWillAppear( animated)
        store.subscribe(self)
        
        
        // Set top border, width = 1, color = 21, 140, 207
        let border1 = CALayer()
        border1.backgroundColor = borderColor
        border1.frame = CGRectMake( 0, 0, self.confirmView.frame.size.width, 1)
        self.confirmView.layer.addSublayer(border1)
        
        
        // Set top border of spacer1, width = 1, color = 21, 140, 207
        let border2 = CALayer()
        border2.backgroundColor = borderColor
        border2.frame = CGRectMake( 0, 0, self.spacer1View.frame.size.width, 1)
        self.spacer1View.layer.addSublayer(border2)
        
        
    }
    
    
    
    /*
     Cancels subscription to AppState modifications
     */
    override func viewWillDisappear( animated: Bool) {
        super.viewWillDisappear( animated)
        store.unsubscribe(self)
    }
    
    
    
}




/*
 Get called when application State changes
 
 Implementation of the ReSwift Unidirectional Data Flow design pattern
 Extension that enable the controller to subscribe to the UIState and react to its changes
 See https://github.com/ReSwift/ReSwift for more explication
 */
extension FOContractController: StoreSubscriber {
    
    
    
    /*
     */
    func newState(state: FOAppState) {
        
        
        // Set new application State
        self.state = state
        
        
        // Update the UI
        self.updateUI()
        
        
        // Remove Progress
        if state.contract != nil {
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
        
        
    }
    
}




//MARK: - Actions and UI Updates

extension FOContractController {
    
    
    
    /*
     */
    func updateUI(){
        
        if let contract = state.contract {
            
            self.contractNumber.text = "\(contract.number)"
            self.contractDate.text = contract.dateFormated.characters.count != 0 ? contract.dateFormated : "NA"
            self.contractValue.text = contract.valueFormatted
            self.addressPostalCode.text = contract.postalCode
            self.addressStreetAndPostalCode.text = contract.streetName + ", " + contract.streetNumber + " - " + contract.complement
            self.district.text = contract.district
            self.cityAndState.text = contract.city + " - " + contract.state
            
        }
        
    }
    
}
