import SwiftUI
import ComposableArchitecture

struct LoginView: View {
  let store: Store<Login.State, Login.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button {
        viewStore.send(.success(User(name: "John Doe")))
      } label: {
        Text("Login")
      }
    }
  }
}

struct CountrySelectorView: View {
  let store: Store<CountrySelector.State, CountrySelector.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        Text("Hello \(viewStore.user.name)")
        Button {
          viewStore.send(.success(viewStore.user, Country(code: "CA")))
        } label: {
          VStack {

            Text("Select Canada")
          }
        }
        Button {
          viewStore.send(.success(viewStore.user, Country(code: "US")))
        } label: {
          VStack {
            Text("Select United States")
          }
        }
      }
    }
  }
}

struct HomeView: View {
  let store: Store<Home.State, Home.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        Text("Hello \(viewStore.user.name) in \(viewStore.country.code)")
        Button {
          viewStore.send(.changeCountry(viewStore.user))
        } label: {
          Text("Change Country")
        }
        Button {
          viewStore.send(.logout)
        } label: {
          Text("Logout")
        }
      }
    }
  }
}

struct CoreView: View {
  let store: Store<Core.State, Core.Action>

  var body: some View {
    WithViewStore(store) { viewStore in
      IfLetStore(store.scope(state: /Core.State.login, action: Core.Action.login),
                              then: LoginView.init(store:))
      IfLetStore(store.scope(state: /Core.State.countrySelector, action: Core.Action.countrySelector),
                                        then: CountrySelectorView.init(store:))
      IfLetStore(store.scope(state: /Core.State.home, action: Core.Action.home),
                             then: HomeView.init(store:))
    }
  }
}
