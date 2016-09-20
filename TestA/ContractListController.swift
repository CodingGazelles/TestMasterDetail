//
//  ContractListController.swift
//  TestA
//
//  Created by Tancrède on 9/15/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import UIKit
import ReSwift
import MRProgress



class FOContractListController: UITableViewController {
    
    
    // State of the application
    let store = FOStore.defaultStore()
    var state: FOAppState!
    
    
    
    
    // The XIB that contains the TableCellView
    var cellViewNib: UINib!
    
    
    
    
    /*
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Connection to the store
        state = store.state
        
        
        // List Contracts and store them in application State
        FOListContractAction.dispatch()
        
        
        // Register table cell view
        cellViewNib = UINib.init(nibName: ContractListItemCellView.Identifier, bundle: nil)
        tableView.registerNib( cellViewNib, forCellReuseIdentifier: ContractListItemCellView.Identifier)
        
        
        // Configure tablerow
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = 110
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.separatorColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        
        
        // Progress
        MRProgressOverlayView.showOverlayAddedTo(self.view, animated: true)
        
        
    }
    
    
    
    
    /*
     Subscribes to AppState modifications
     */
    override func viewWillAppear( animated: Bool) {
        super.viewWillAppear( animated)
        store.subscribe(self)
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
extension FOContractListController: StoreSubscriber {
    
    
    /*
     */
    func newState(state: FOAppState) {
        
        
        // Set new application State
        self.state = state
        
        
        // Update the UI
        tableView.reloadData()
        
        
        // Remove Progress
        if state.contractList  != nil {
            MRProgressOverlayView.dismissOverlayForView(self.view, animated: true)
        }
        
    }
    
}




// MARK: - conformance to UITableViewDataSource

/*
 */
extension FOContractListController {
    
    
    /*
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    /*
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.contractList?.list.count ?? 0
    }
    
    
    
    /*
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // Get TableCell
        let cell = tableView.dequeueReusableCellWithIdentifier( ContractListItemCellView.Identifier, forIndexPath: indexPath) as! ContractListItemCellView
        
        
        // Get ContractListItem
        let item = state.contractList!.list[indexPath.row]
        
        
        // Update Cell with ContractListItem
        cell.contractNumber.text = "\(item.number)"
        cell.contractDate.text = "\(item.dateFormatted)"
        cell.contractValue.text = item.valueFormatted
        
        
        return cell
        
    }
    
    
}




// MARK: - conformance to UITableViewDelegate

/*
 */
extension FOContractListController {


    
    /*
     Sends an Action to get the selected Contrat and insert it in application State
    */
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        
        // send Action to insert selected Contract in application State
        FOGetContractAction.dispatch()
        
        
        // Clean table
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        // Push ContractViewController
        let contractVC = self.storyboard!.instantiateViewControllerWithIdentifier(FOContractController.Identifier) as! FOContractController
        self.navigationController!.pushViewController(contractVC, animated: true)
        
        
        return nil
        
    }
    
    
    
}