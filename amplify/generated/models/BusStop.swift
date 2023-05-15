// swiftlint:disable all
import Amplify
import Foundation

public struct BusStop: Model {
  public let id: String
  public var language: Language
  public var name: String
  public var description: String?
  public var enabled: Bool
  public var thumbnailUrl: String
  public var videoUrl: String?
  public var tourID: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      language: Language,
      name: String,
      description: String? = nil,
      enabled: Bool,
      thumbnailUrl: String,
      videoUrl: String? = nil,
      tourID: String? = nil) {
    self.init(id: id,
      language: language,
      name: name,
      description: description,
      enabled: enabled,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      tourID: tourID,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      language: Language,
      name: String,
      description: String? = nil,
      enabled: Bool,
      thumbnailUrl: String,
      videoUrl: String? = nil,
      tourID: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.language = language
      self.name = name
      self.description = description
      self.enabled = enabled
      self.thumbnailUrl = thumbnailUrl
      self.videoUrl = videoUrl
      self.tourID = tourID
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}