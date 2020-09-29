import Foundation
import Combine
import ComposableArchitecture

enum Login {
  static let reducer = Reducer<State, Action, Environment> { state, action, environment in
    return .none
  }

  struct State: Equatable {
  }

  enum Action: Equatable {
    case success(User)
  }

  struct Environment {
  }
}
