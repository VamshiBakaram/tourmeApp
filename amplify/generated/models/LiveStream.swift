// swiftlint:disable all
import Amplify
import Foundation

public struct LiveStream: Model {
  public let id: String
  public var language: Language
  public var name: String
  public var streamDate: Temporal.DateTime?
  public var description: String?
  public var enabled: Bool
  public var thumbnailUrl: String
  public var videoUrl: String
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      language: Language,
      name: String,
      streamDate: Temporal.DateTime? = nil,
      description: String? = nil,
      enabled: Bool,
      thumbnailUrl: String,
      videoUrl: String) {
    self.init(id: id,
      language: language,
      name: name,
      streamDate: streamDate,
      description: description,
      enabled: enabled,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      language: Language,
      name: String,
      streamDate: Temporal.DateTime? = nil,
      description: String? = nil,
      enabled: Bool,
      thumbnailUrl: String,
      videoUrl: String,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.language = language
      self.name = name
      self.streamDate = streamDate
      self.description = description
      self.enabled = enabled
      self.thumbnailUrl = thumbnailUrl
      self.videoUrl = videoUrl
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}