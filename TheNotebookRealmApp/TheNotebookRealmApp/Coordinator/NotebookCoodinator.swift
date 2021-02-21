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
        viewModel.coordinatorDelegate = self
        
        self.presenter.setViewControllers([controller], animated: true)
        
    }
    
    override func finish() {
        
    }
    
}


extension NotebookCoordinator: NotebookCoordinatorDelegate{
    
    func didSelectANotebook(notebook: Notebook) {
        let noteViewModel = NoteViewModel(belongsTo: notebook)
        let noteViewController = NoteViewController(noteViewModel: noteViewModel)
        noteViewModel.delegate = noteViewController
        //
        self.presenter.pushViewController(noteViewController, animated: true)
    }
}
