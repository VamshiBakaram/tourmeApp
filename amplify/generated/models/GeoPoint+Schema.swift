// swiftlint:disable all
import Amplify
import Foundation

extension GeoPoint {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case lat
    case lon
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let geoPoint = GeoPoint.keys
    
    model.pluralName = "GeoPoints"
    
    model.fields(
      .field(geoPoint.lat, is: .optional, ofType: .double),
      .field(geoPoint.lon, is: .optional, ofType: .double)
    )
    }
}