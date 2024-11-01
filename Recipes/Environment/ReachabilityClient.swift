import Foundation
import ComposableArchitecture
import NetworkReachability

struct ReachabilityClient {
    var isReachable: () -> Effect<Bool>
}

extension ReachabilityClient: DependencyKey {
    static let liveValue: ReachabilityClient = {
        
        return ReachabilityClient(
            isReachable: {
                Effect.run { send in
                    
                    for await update in NetworkMonitor.networkPathUpdates {
                        
                        if Task.isCancelled { break }
                        switch update.status {
                        case .requiresConnection:
                            send(false)
                        case .satisfied:
                            send(true)
                        case .unsatisfied:
                            send(false)
                        default:
                            send(false)
                        }
                    }
                }
            }
        )
    }()
    
    static var testValue: ReachabilityClient = {
        return ReachabilityClient(
            isReachable: {
                Effect.run { send in
                    send(true)
                }
            }
        )
    }()
}

// MARK: - DependencyValues extension for ReachabilityClient

extension DependencyValues {
    var reachabilityClient: ReachabilityClient {
        get { self[ReachabilityClient.self] }
        set { self[ReachabilityClient.self] = newValue }
    }
}
