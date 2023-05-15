// swiftlint:disable all
import Amplify
import Foundation

extension Tour {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case language
    case name
    case description
    case enabled
    case position
    case thumbnailUrl
    case videoUrl
    case tourstID
    case BusStops
    case sortOrder
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let tour = Tour.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.read])
    ]
    
    model.pluralName = "Tours"
    
    model.attributes(
      .index(fields: ["tourstID"], name: "byTourSt")
    )
    
    model.fields(
      .id(),
      .field(tour.language, is: .required, ofType: .enum(type: Language.self)),
      .field(tour.name, is: .required, ofType: .string),
      .field(tour.description, is: .optional, ofType: .string),
      .field(tour.enabled, is: .required, ofType: .bool),
      .field(tour.position, is: .required, ofType: .embedded(type: GeoPoint.self)),
      .field(tour.thumbnailUrl, is: .required, ofType: .string),
      .field(tour.videoUrl, is: .optional, ofType: .string),
      .field(tour.tourstID, is: .optional, ofType: .string),
      .hasMany(tour.BusStops, is: .optional, ofType: BusStop.self, associatedWith: BusStop.keys.tourID),
      .field(tour.sortOrder, is: .optional, ofType: .int),
      .field(tour.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(tour.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}