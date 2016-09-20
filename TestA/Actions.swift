//
//  FOReducer.swift
//  TestA
//
//  Created by Tancrède on 9/14/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import Foundation
import ReSwift




/*
 Modifies the State according to the Action dispatched
 Is called by the Store when an Action is dispatched
 */
class FOReducer: Reducer {
    
    func handleAction(action: Action, state: FOAppState?) -> FOAppState {
        
        
        var state = state ?? FOAppState()
        
        switch action {
        case let action as FOListContractAction:
            
            state.contractList = action.list
            
            
        case let action as FOGetContractAction:
            
            state.contract = action.contract
            
        default:
            break
        }
        
        return state
        
    }
    
    
}




/*
 Action that lists the contracts
 Action are dispatched to the Store when the application needs to change its State
 */
class FOListContractAction: Action {
    
    let list: FOContractList
    
    private init( list: FOContractList){
        self.list = list
    }
    
    static func dispatch() {
        
        // getting the DataStack
        FODataStack.defaultStack().listContracts()
            .onSuccess{ list in
                
                // listing the contacts
                let action = FOListContractAction(list: list)
                
                // send the Action to the Reducer
                FOStore.defaultStore().dispatch(action)
                
                
            }
            .onFailure{ error in
                debugPrint(error)
        }
        
    }
}




/*
 Action that gets a contract
 Action are dispatched to the Store when the application needs to change its State
 */
class FOGetContractAction: Action {
    
    let contract: FOContract
    
    private init( contract: FOContract){
        self.contract = contract
    }
    
    static func dispatch() {
        
        // getting the DataStack
        FODataStack.defaultStack().getContract()
            .onSuccess{ contract in
                
                
                // getting the contact
                let action = FOGetContractAction(contract: contract)
                
                
                // send the Action to the Reducer
                FOStore.defaultStore().dispatch(action)
                
                
            }
            .onFailure{ error in
                debugPrint(error)
        }
        
    }
}


