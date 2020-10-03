//
//  Store.swift
//  HelloRedux
//
//  Created by Mohammad Azam on 9/14/20.
//

import Foundation

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State

protocol ReduxState { }

struct AppState: ReduxState {
    var counterState = CounterState()
    var taskState = TaskState()
}

struct TaskState: ReduxState {
    var tasks: [Task] = [Task]()
}

struct CounterState: ReduxState {
    var counter = 0
}

protocol Action { }

struct IncrementAction: Action { }
struct DecrementAction: Action { }
struct AddTaskAction: Action {
    let task: Task 
}


struct AddAction: Action {
    let value: Int
}

class Store<StoreState: ReduxState>: ObservableObject {
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        state = reducer(state, action)
    }
    
}
