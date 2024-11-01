import ComposableArchitecture

@Reducer
struct AppFeature {
    
    @ObservableState
    struct State: Equatable {
        
        var lifecycleState: Lifecycle = .startup
        var isReachable: Bool
        var offline: Bool = false
        
        init(isReachable: Bool) {
            self.isReachable = isReachable
            self.offline = !isReachable
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case startMonitoringNetwork
        case stopMonitoringNetwork
        case lifecycleEventChanged(Lifecycle)
        case networkReachabilityChanged(Bool)
    }
    
    enum Lifecycle {
        case startup
        case active
        case inactive
        case background
    }
    
    fileprivate static let networkReachabilityKey: String = "network-reachability"
    
    
    var body: some Reducer<State,Action> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .stopMonitoringNetwork:
                print("Stop Monitoring Network")
                return .cancel(id: Self.networkReachabilityKey)
            case .startMonitoringNetwork:
                print("Start Monitoring Network")
                return Dependency(\.reachabilityClient).wrappedValue.isReachable()
                    .map { @Sendable isReachable in
                        
                        print("App has network connectivity = \(isReachable)")
                        return Action.networkReachabilityChanged(isReachable)
                    }
                    .cancellable(id: Self.networkReachabilityKey, cancelInFlight: true)
            case .networkReachabilityChanged(let new):
                state.isReachable = new
                state.offline = !state.isReachable
                return .none
            case .lifecycleEventChanged(let event):
                state.lifecycleState = event //update state
                switch event {
                case .active:
                    return .send(.startMonitoringNetwork)
                case .inactive:
                    return .send(.stopMonitoringNetwork)
                case .background:
                    return .send(.stopMonitoringNetwork)
                case .startup:
                    return .none
                }
            }
        }
    }
}
