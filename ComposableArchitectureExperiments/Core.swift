import Foundation
import Combine
import ComposableArchitecture

enum Core {
  typealias CoreReducer = Reducer<State, Action, Environment>

  static let reducer = Reducer.combine(loginReducer, countrySelectorReducer, homeReducer, coreReducer).debug()

  private static let coreReducer = CoreReducer { state, action, environment in
    switch action {
    case .login(.success(let user)):
      state = .countrySelector(.init(user: user))
    case let .countrySelector(.success(user, country)):
      state = .home(.init(user: user, country: country))
    case let .home(.changeCountry(user)):
      state = .countrySelector(.init(user: user))
    case .home(.logout):
      state = .login(.init())
    }
    return .none
  }

  private static let loginReducer: CoreReducer =
    Login.reducer.pullback(state: /Core.State.login, action: /Core.Action.login) { _ in
      Login.Environment()
    }

  private static let countrySelectorReducer: CoreReducer =
    CountrySelector.reducer.pullback(state: /Core.State.countrySelector, action: /Core.Action.countrySelector) { _ in
      CountrySelector.Environment()
    }

  private static let homeReducer: CoreReducer =
    Home.reducer.pullback(state: /Core.State.home, action: /Core.Action.home) { _ in
      Home.Environment()
    }

  enum State: Equatable {
    case login(Login.State)
    case countrySelector(CountrySelector.State)
    case home(Home.State)
  }

  enum Action: Equatable {
    case login(Login.Action)
    case countrySelector(CountrySelector.Action)
    case home(Home.Action)
  }

  struct Environment {
  }
}

struct User: Equatable {
  let name: String
}
