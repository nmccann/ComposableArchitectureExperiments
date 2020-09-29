import SwiftUI
import ComposableArchitecture

@main
struct ComposableArchitectureExperimentsApp: App {
    var body: some Scene {
        WindowGroup {
            CoreView(store: Store(initialState: Core.State.login(Login.State()),
                                  reducer: Core.reducer,
                                  environment: Core.Environment()))
        }
    }
}
