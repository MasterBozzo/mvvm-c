//
//  EventDetailCoordinator.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 06/07/2021.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
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
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event,
                                                        navigationController: navigationController)
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
}
