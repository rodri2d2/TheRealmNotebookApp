//
//  NotebookCoodinator.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit

class NotebookCoordinator: Coordinator {
    
    
    // MARK: - Class properties
    private let presenter: UINavigationController
    
    // MARK: - Lifecyle
    init(appPresenter: UINavigationController) {
        self.presenter = appPresenter
    }
    
    
    
    // MARK: - Coordinator override methods
    override func start() {
            
        let viewModel      = NotebookViewModel()
        let controller     = NotebookViewController(notebookViewModel: viewModel)
        viewModel.delegate = controller
        
        self.presenter.setViewControllers([controller], animated: true)
        
    }
    
    override func finish() {
        
    }
    
}
