// swiftlint:disable all
import Amplify
import Foundation

extension HomeContent {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case language
    case title
    case description
    case thumbnailUrl
    case enabled
    case buttonText
    case showButton
    case keyword
    case sortOrder
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let homeContent = HomeContent.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "HomeContents"
    
    model.fields(
      .id(),
      .field(homeContent.language, is: .required, ofType: .enum(type: Language.self)),
      .field(homeContent.title, is: .required, ofType: .string),
      .field(homeContent.description, is: .required, ofType: .string),
      .field(homeContent.thumbnailUrl, is: .required, ofType: .string),
      .field(homeContent.enabled, is: .required, ofType: .bool),
      .field(homeContent.buttonText, is: .optional, ofType: .string),
      .field(homeContent.showButton, is: .optional, ofType: .bool),
      .field(homeContent.keyword, is: .optional, ofType: .string),
      .field(homeContent.sortOrder, is: .required, ofType: .int),
      .field(homeContent.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(homeContent.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}