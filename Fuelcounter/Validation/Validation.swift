//
//  Validation.swift
//  Fuelcounter
//
//  Created by Nelson on 11/06/2020.
//  Copyright © 2020 Nelson. All rights reserved.
//https://medium.com/@chongye225/python-regular-expression-2ac91e084662

import Foundation
class Validation {
    
   public func validateNaam(naam: String) ->Bool {
      // max 18 characters min  3 characters
      let nameRegex = "^\\w{3,18}$"
      let trimmedString = naam.trimmingCharacters(in: .whitespaces)
      let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
      let isValidateName = validateName.evaluate(with: trimmedString)
      return isValidateName
   }
    
   public func validaNumber(number: String) -> Bool {
      let numberRegex = "[0-9]"
      let trimmedString = number.trimmingCharacters(in: .whitespaces)
      let validateNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex)
      let isValidNumber = validateNumber.evaluate(with: trimmedString)
      return isValidNumber
   }
    
   public func validateDate(datum: Int) -> Bool {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy"
    let formattedDate :String = format.string(from: date)
    let isValidNumber = datum > 1900 && datum <= Int(formattedDate)! ? true : false
    return isValidNumber
   }
    
   public func validateType(type: String) -> Bool {
        let typeArray = ["-maak een keuze-","andere","bezine","diesel","electrisch","lpg"]
        let isTypeValid : Bool = typeArray.contains(type)
        return isTypeValid
   }
    
}
