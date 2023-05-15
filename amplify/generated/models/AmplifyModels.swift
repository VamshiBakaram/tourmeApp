// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "29f38cfd3b91d69a91fa8fa2bdbdea93"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UserProfile.self)
    ModelRegistry.register(modelType: Purchase.self)
    ModelRegistry.register(modelType: HomeContent.self)
    ModelRegistry.register(modelType: LiveStream.self)
    ModelRegistry.register(modelType: BusStop.self)
    ModelRegistry.register(modelType: Tour.self)
  }
}