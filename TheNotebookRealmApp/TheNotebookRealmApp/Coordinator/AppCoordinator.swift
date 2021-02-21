//
//  AppCoordinator.swift
//  TheNotebookRealmApp
//
//  Created by Rodrigo  Candido on 21/2/21.
//

import UIKit
/**
 This class controls the entire app navigation based on Coordinator Pattern. It is App Main Coordinator Class
 
 Its start method asign to app Window a rootNavigationController as UINavigationController.
 
 - Author: Rodrigo Candido
 - Version: v1.0
 */
class AppCoordinator: Coordinator {
    

    // MARK: - Class properties
    private var window: UIWindow
    
    // MARK: - Lifecycle
    init(sceneWindow: UIWindow){
        self.window = sceneWindow
    }
    
    
    // MARK: - Coordinator override methods
    override func start() {
        
        //
        let navigationController = UINavigationController()
        //
        let notebookCoordinator = NotebookCoordinator(appPresenter: navigationController)
        addChildCoordinator(notebookCoordinator)
        notebookCoordinator.start()
        //
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
    
}
