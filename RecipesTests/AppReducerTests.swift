import Testing
import ComposableArchitecture

@testable import Recipes

struct AppReducerTests {

    @Test func testReachabilityTrue() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        let store = await TestStore(
            initialState: AppFeature.State(isReachable: false)
        ) {
            AppFeature()
        } withDependencies: { deps in
            deps.reachabilityClient.isReachable = {
                .send(true)
            }
        }
        
        await store.send(.startMonitoringNetwork)
        //Make sure both isReachable & offline mode are correct.
        await store.receive(\.networkReachabilityChanged) {
            $0.isReachable = true
            $0.offline = false
        }
    }
    @Test func testReachabilityFalse() async throws {
        let store = await TestStore(
            initialState: AppFeature.State(isReachable: false)
        ) {
            AppFeature()
        } withDependencies: { deps in
            deps.reachabilityClient.isReachable = {
                .send(false)
            }
        }
    
        await store.send(.startMonitoringNetwork)
        await store
            .receive(
                \.networkReachabilityChanged
            ) //no change, default value false.
    
    }
    
    @Test func testReachabilityCanChange() async throws {
        let store = await TestStore(
            initialState: AppFeature.State(isReachable: false)
        ) {
            AppFeature()
        } withDependencies: { deps in
            deps.reachabilityClient.isReachable = {
                .send(false)
            }
        }
    
        await store.send(.startMonitoringNetwork)
        await store
            .receive(
                \.networkReachabilityChanged
            )
        
        //Make sure both isReachable & offline are in the correct states
        await store.send(.networkReachabilityChanged(true)) {
            $0.isReachable = true
            $0.offline = false
        }
    
    }
    
    @Test func testAppLifecycle() async throws {
        let store = await TestStore(
            initialState: AppFeature.State(isReachable: false)
        ) {
            AppFeature()
        } withDependencies: { deps in
            deps.reachabilityClient.isReachable = {
                .send(false)
            }
        }
    
        await store.send(.lifecycleEventChanged(.active)) {
            $0.lifecycleState = .active
        }
        await store.receive(\.startMonitoringNetwork)
        await store.receive(\.networkReachabilityChanged)

    }
}
