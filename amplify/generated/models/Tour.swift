// swiftlint:disable all
import Amplify
import Foundation

public struct Tour: Model {
  public let id: String
  public var language: String
  public var name: String
  public var description: String?
  public var enabled: Bool
  public var position: GeoPoint
  public var thumbnailUrl: String
  public var videoUrl: String?
  public var tourstID: String?
  public var BusStops: BusStopModel?
  public var sortOrder: Int?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      language: String,
      name: String,
      description: String? = nil,
      enabled: Bool,
      position: GeoPoint,
      thumbnailUrl: String,
      videoUrl: String? = nil,
      tourstID: String? = nil,
      BusStops: BusStopModel? = nil,
      sortOrder: Int? = nil) {
    self.init(id: id,
      language: language,
      name: name,
      description: description,
      enabled: enabled,
      position: position,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      tourstID: tourstID,
      BusStops: BusStops,
      sortOrder: sortOrder,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      language: String,
      name: String,
      description: String? = nil,
      enabled: Bool,
      position: GeoPoint,
      thumbnailUrl: String,
      videoUrl: String? = nil,
      tourstID: String? = nil,
      BusStops: BusStopModel? = nil,
      sortOrder: Int? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.language = language
      self.name = name
      self.description = description
      self.enabled = enabled
      self.position = position
      self.thumbnailUrl = thumbnailUrl
      self.videoUrl = videoUrl
      self.tourstID = tourstID
      self.BusStops = BusStops
      self.sortOrder = sortOrder
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}
