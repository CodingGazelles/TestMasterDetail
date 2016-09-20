//
//  FOContract.swift
//  TestA
//
//  Created by Tancrède on 9/14/16.
//  Copyright © 2016 William Vasconcelos. All rights reserved.
//

import Foundation




/*
 */
typealias JsonDictionary = Dictionary<String, AnyObject>




/*
 */
struct FOContractList {
    
    var list: Array<FOContractListItem>
    
    
    /*
     Instanciates Contracts from data in Json
     */
    init( json: JsonDictionary) {
        
        self.list = Array<FOContractListItem>()
        
        
        let jsonArray = json[FOJsonKeys.listaContrato] as! Array<JsonDictionary>
        
        
        // Instanciates ContractList from data in Json
        for item in jsonArray {
            let contract = FOContractListItem(json: item)
            list.append(contract)
        }
        
    }
    
    
}




/*
 */
struct FOContractListItem {
    
    
    //
    let number: Int
    let dateFormatted: String
    let value: Float
    
    
    // Computed props
    private let valueFormatter: NSNumberFormatter
    var valueFormatted: String {
        return self.valueFormatter.stringFromNumber(self.value) ?? ""
    }
    
    
    
    
    /*
     */
    init( number: Int, dateFormatted: String, value: Float){
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        self.valueFormatter = formatter
        
        self.number = number
        self.dateFormatted = dateFormatted
        self.value = value
        
    }
    
    
    
    /*
     Instanciates ContractListItem from data in Json
     */
    init( json: JsonDictionary){
        
        let number = json[FOJsonKeys.nuContrato] as! Int
        let dateFormatted = json[FOJsonKeys.dtBaseContratoFormatado] as! String
        let value = json[FOJsonKeys.nuCarteira] as! Float
        
        self.init( number: number, dateFormatted: dateFormatted, value: value)
        
    }

    
}




/*
 */
struct FOContract {
    
    
    //
    let number: Int
    let dateFormated: String
    let value: Float
    let postalCode: String
    let streetName: String
    let streetNumber: String
    let district: String
    let city: String
    let state: String
    let complement: String
    
    
    // Computed props
    private let valueFormatter: NSNumberFormatter
    var valueFormatted: String {
        return self.valueFormatter.stringFromNumber(self.value) ?? ""
    }
    
    
    /*
    */
    init( number: Int, dateFormated: String, value: Float, postalCode: String, streetName: String, streetNumber: String, district: String, city: String, state: String, complement: String){
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        self.valueFormatter = formatter
        
        self.number = number
        self.dateFormated = dateFormated
        self.value = value
        self.postalCode = postalCode
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.district = district
        self.city = city
        self.state = state
        self.complement = complement
        
    }
    
    
    
    /*
    */
    init( json: JsonDictionary){
        
        let contract = json[FOJsonKeys.contrato] as! Dictionary<String, AnyObject>
        let number = contract[FOJsonKeys.nuContrato] as! Int
        let dateFormated = contract[FOJsonKeys.dtBaseContratoFormatado] as! String
        let value = contract[FOJsonKeys.nuCarteira] as! Float
        let address = contract[FOJsonKeys.endereco] as! Dictionary<String, AnyObject>
        let postalCode = address[FOJsonKeys.cdCep1] as! String + "-" + (address[FOJsonKeys.cdCep2] as! String)
        
        let streetName = (address[FOJsonKeys.dsEndereco] as! String)
            .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let streetNumber = address[FOJsonKeys.nuEndereco] as! String
        
        let district = (address[FOJsonKeys.dsBairro] as! String)
            .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let city = (address[FOJsonKeys.dsCidade] as! String)
            .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let state = (address[FOJsonKeys.cdUf ] as! String)
            .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let complement = address[FOJsonKeys.dsComplemento] as! String
        
        self.init( number: number, dateFormated: dateFormated, value: value, postalCode: postalCode, streetName: streetName, streetNumber: streetNumber, district: district, city: city, state: state, complement: complement)
        
    }
    
    
}




/*
 */
enum FOJsonKeys: String {
    
    case listaContrato
    case contrato
    case nuContrato
    case dtBaseContrato
    case dtBaseContratoFormatado
    case nuCarteira
    case endereco
    case dsEndereco
    case nuEndereco
    case cdCep1
    case cdCep2
    case dsBairro
    case dsCidade
    case cdUf
    case dsComplemento
    
}




/*
 Overload Subscript of the JsonDictionary to accept a FOJsonKeys as Index
 */
extension Dictionary where Key: StringLiteralConvertible, Value: AnyObject {
    
    subscript(index: FOJsonKeys) -> AnyObject {
        get {
            return self[ index.rawValue as! Key] as! AnyObject
        }
    }
    
}



