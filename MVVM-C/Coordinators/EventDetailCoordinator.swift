//
//  EventDetailCoordinator.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 06/07/2021.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: EventListCoordinator?
    
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    
    init(eventID: NSManagedObjectID,
         navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let detailViewController = EventDetailViewController()
        let viewModel = EventDetailViewModel(eventID: eventID)
        viewModel.coordinator = self
        detailViewController.viewModel = viewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
