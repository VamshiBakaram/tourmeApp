// swiftlint:disable all
import Amplify
import Foundation

extension LiveStream {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case language
    case name
    case streamDate
    case description
    case enabled
    case thumbnailUrl
    case videoUrl
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let liveStream = LiveStream.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "LiveStreams"
    
    model.fields(
      .id(),
      .field(liveStream.language, is: .required, ofType: .enum(type: Language.self)),
      .field(liveStream.name, is: .required, ofType: .string),
      .field(liveStream.streamDate, is: .optional, ofType: .dateTime),
      .field(liveStream.description, is: .optional, ofType: .string),
      .field(liveStream.enabled, is: .required, ofType: .bool),
      .field(liveStream.thumbnailUrl, is: .required, ofType: .string),
      .field(liveStream.videoUrl, is: .required, ofType: .string),
      .field(liveStream.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(liveStream.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}