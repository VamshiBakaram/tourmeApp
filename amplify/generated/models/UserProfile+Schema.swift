// swiftlint:disable all
import Amplify
import Foundation

extension UserProfile {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case email
    case phone
    case displayName
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let userProfile = UserProfile.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "UserProfiles"
    
    model.fields(
      .id(),
      .field(userProfile.email, is: .optional, ofType: .string),
      .field(userProfile.phone, is: .optional, ofType: .string),
      .field(userProfile.displayName, is: .optional, ofType: .string),
      .field(userProfile.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(userProfile.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}