import Foundation
import Combine
import ComposableArchitecture

enum Home {
  static let reducer = Reducer<State, Action, Environment> { state, action, environment in
    return .none
  }

  struct State: Equatable {
    let user: User
    let country: Country
  }

  enum Action: Equatable {
    case changeCountry(User)
    case logout
  }

  struct Environment {
  }
}
