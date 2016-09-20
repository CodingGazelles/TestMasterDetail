//
//  FOAppState.swift
//  TestA
//
//  Created by Tancrède on 9/14/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import Foundation
import ReSwift




/*
 The application State contains all application information
 This is where the View will get all it needs to set its values
 */
struct FOAppState: StateType {
    var contractList: FOContractList?
    var contract: FOContract?
}




/*
 The Store 'stores' the Application State and dispatches all the Actions to the appropriate Receiver
 */
//typealias FOStore = Store<FOAppState>

class FOStore {
    
    // Singleton
    private init(){}
    private static let defaultInstance = Store<FOAppState>( reducer: FOReducer(), state: nil)
    static func defaultStore() -> Store<FOAppState> {
        return defaultInstance
    }
    
    
}