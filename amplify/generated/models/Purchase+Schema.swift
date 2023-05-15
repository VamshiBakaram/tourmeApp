// swiftlint:disable all
import Amplify
import Foundation

extension Purchase {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case email
    case enabled
    case purchaseAmount
    case purchaseLevel
    case purchaseDate
    case phone
    case invoiceNumber
    case name
    case purchaseIPAddress
    case billingAddress
    case billingCity
    case billingState
    case billingCountry
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let purchase = Purchase.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Purchases"
    
    model.fields(
      .id(),
      .field(purchase.email, is: .required, ofType: .string),
      .field(purchase.enabled, is: .required, ofType: .bool),
      .field(purchase.purchaseAmount, is: .required, ofType: .double),
      .field(purchase.purchaseLevel, is: .required, ofType: .string),
      .field(purchase.purchaseDate, is: .optional, ofType: .dateTime),
      .field(purchase.phone, is: .optional, ofType: .string),
      .field(purchase.invoiceNumber, is: .optional, ofType: .string),
      .field(purchase.name, is: .optional, ofType: .string),
      .field(purchase.purchaseIPAddress, is: .optional, ofType: .string),
      .field(purchase.billingAddress, is: .optional, ofType: .string),
      .field(purchase.billingCity, is: .optional, ofType: .string),
      .field(purchase.billingState, is: .optional, ofType: .string),
      .field(purchase.billingCountry, is: .optional, ofType: .string),
      .field(purchase.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(purchase.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}