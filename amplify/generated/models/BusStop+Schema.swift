// swiftlint:disable all
import Amplify
import Foundation

extension BusStop {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case language
    case name
    case description
    case enabled
    case thumbnailUrl
    case videoUrl
    case tourID
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let busStop = BusStop.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "BusStops"
    
    model.attributes(
      .index(fields: ["tourID"], name: "byTour")
    )
    
    model.fields(
      .id(),
      .field(busStop.language, is: .required, ofType: .enum(type: Language.self)),
      .field(busStop.name, is: .required, ofType: .string),
      .field(busStop.description, is: .optional, ofType: .string),
      .field(busStop.enabled, is: .required, ofType: .bool),
      .field(busStop.thumbnailUrl, is: .required, ofType: .string),
      .field(busStop.videoUrl, is: .optional, ofType: .string),
      .field(busStop.tourID, is: .optional, ofType: .string),
      .field(busStop.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(busStop.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}