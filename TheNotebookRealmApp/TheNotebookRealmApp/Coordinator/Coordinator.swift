//
//  Coordinator.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import Foundation


/// All coordinator class must extent this class and implement start() and finish() methods
class Coordinator {
    
    
    /// To keep a reference of this class extension children
    fileprivate var childCoordinators: [Coordinator] = []

    
    /// This function must be overrided by a extended class. All inicial istrunction to "call" a controller goes here
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    
    /// /// This function must be overrided by a extended class. Should be call to execute tasks once the controller will finish and then be removed from children reference
    func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
        
    }

    
    /// Add to its parent coodinator as a reference
    /// - Parameter coordinator: type Coordinator
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    
    /// Remove from its parent coordinator
    /// - Parameter coordinator: type Coordinator
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
}

extension Coordinator: Equatable {

    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }

}
