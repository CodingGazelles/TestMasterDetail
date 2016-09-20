//
//  FSDataStack.swift
//  TestA
//
//  Created by Tancrède on 9/14/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import Foundation
import BrightFutures
import Alamofire
import Result





/*
 */
class FODataStack {
    
    
    
    // Singleton
    private init(){}
    private static let defaultInstance = FODataStack()
    static func defaultStack() -> FODataStack {
        return defaultInstance
    }
    
    
    
    
    /*
     */
    func listContracts() -> Future<FOContractList, FOListContractError> {
        
        let promise = Promise<FOContractList, FOListContractError>()
        
        Queue.global.context {
            
            
            //
            Alamofire.request( .GET, FOUrlStore.listContracts)
                .responseJSON { response in
                    
                    // simulate 5 sec download time
                    NSThread.sleepForTimeInterval(5)
                    
                    
                switch response.result {
                case .Success( let value):
                    
                    promise.success( FOContractList(json: value as! JsonDictionary))
                    
                    
                case .Failure(let error):
                    promise.failure( FOListContractError( rootError: error))
                }
            }
            
            
        }
        
        
        return promise.future
        
    }
    
    
    
    /*
     */
    func getContract() -> Future<FOContract, FOGetContractError> {
        
        let promise = Promise<FOContract, FOGetContractError>()
        
        Queue.global.context {
            
            
            //
            Alamofire.request( .GET, FOUrlStore.getContract)
                .responseJSON { response in
                    
                    // simulate 5 sec download time
                    NSThread.sleepForTimeInterval(5)
                    
                switch response.result {
                case .Success( let value):
                    
                    promise.success( FOContract( json: value as! Dictionary))
                    
                    
                case .Failure(let error):
                    promise.failure( FOGetContractError( rootError: error))
                }
            }
            
            
        }
        
        
        return promise.future
        
    }
    
    
}





class FOError: ErrorType {
    var rootError: ErrorType?
    init( rootError: ErrorType?){
        self.rootError = rootError
    }
}
class FOListContractError: FOError {}
class FOGetContractError: FOError {}



