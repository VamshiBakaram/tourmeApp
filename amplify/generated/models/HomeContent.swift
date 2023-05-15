// swiftlint:disable all
import Amplify
import Foundation

public struct HomeContent: Model {
  public let id: String
  public var language: Language
  public var title: String
  public var description: String
  public var thumbnailUrl: String
  public var enabled: Bool
  public var buttonText: String?
  public var showButton: Bool?
  public var keyword: String?
  public var sortOrder: Int
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      language: Language,
      title: String,
      description: String,
      thumbnailUrl: String,
      enabled: Bool,
      buttonText: String? = nil,
      showButton: Bool? = nil,
      keyword: String? = nil,
      sortOrder: Int) {
    self.init(id: id,
      language: language,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      enabled: enabled,
      buttonText: buttonText,
      showButton: showButton,
      keyword: keyword,
      sortOrder: sortOrder,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      language: Language,
      title: String,
      description: String,
      thumbnailUrl: String,
      enabled: Bool,
      buttonText: String? = nil,
      showButton: Bool? = nil,
      keyword: String? = nil,
      sortOrder: Int,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.language = language
      self.title = title
      self.description = description
      self.thumbnailUrl = thumbnailUrl
      self.enabled = enabled
      self.buttonText = buttonText
      self.showButton = showButton
      self.keyword = keyword
      self.sortOrder = sortOrder
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}