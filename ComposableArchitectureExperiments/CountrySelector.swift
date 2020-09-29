import Foundation
import Combine
import ComposableArchitecture

enum CountrySelector {
  static let reducer = Reducer<State, Action, Environment> { state, action, environment in
    return .none
  }

  struct State: Equatable {
    let user: User
  }

  enum Action: Equatable {
    case success(User, Country)
  }

  struct Environment {
  }
}

struct Country: Equatable {
  let code: String
}
