// swiftlint:disable all
import Amplify
import Foundation

public struct Purchase: Model {
  public let id: String
  public var email: String
  public var enabled: Bool
  public var purchaseAmount: Double
  public var purchaseLevel: String
  public var purchaseDate: Temporal.DateTime?
  public var phone: String?
  public var invoiceNumber: String?
  public var name: String?
  public var purchaseIPAddress: String?
  public var billingAddress: String?
  public var billingCity: String?
  public var billingState: String?
  public var billingCountry: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      email: String,
      enabled: Bool,
      purchaseAmount: Double,
      purchaseLevel: String,
      purchaseDate: Temporal.DateTime? = nil,
      phone: String? = nil,
      invoiceNumber: String? = nil,
      name: String? = nil,
      purchaseIPAddress: String? = nil,
      billingAddress: String? = nil,
      billingCity: String? = nil,
      billingState: String? = nil,
      billingCountry: String? = nil) {
    self.init(id: id,
      email: email,
      enabled: enabled,
      purchaseAmount: purchaseAmount,
      purchaseLevel: purchaseLevel,
      purchaseDate: purchaseDate,
      phone: phone,
      invoiceNumber: invoiceNumber,
      name: name,
      purchaseIPAddress: purchaseIPAddress,
      billingAddress: billingAddress,
      billingCity: billingCity,
      billingState: billingState,
      billingCountry: billingCountry,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      email: String,
      enabled: Bool,
      purchaseAmount: Double,
      purchaseLevel: String,
      purchaseDate: Temporal.DateTime? = nil,
      phone: String? = nil,
      invoiceNumber: String? = nil,
      name: String? = nil,
      purchaseIPAddress: String? = nil,
      billingAddress: String? = nil,
      billingCity: String? = nil,
      billingState: String? = nil,
      billingCountry: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.email = email
      self.enabled = enabled
      self.purchaseAmount = purchaseAmount
      self.purchaseLevel = purchaseLevel
      self.purchaseDate = purchaseDate
      self.phone = phone
      self.invoiceNumber = invoiceNumber
      self.name = name
      self.purchaseIPAddress = purchaseIPAddress
      self.billingAddress = billingAddress
      self.billingCity = billingCity
      self.billingState = billingState
      self.billingCountry = billingCountry
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}