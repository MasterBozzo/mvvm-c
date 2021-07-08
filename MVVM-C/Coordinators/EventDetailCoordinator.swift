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
    var onUpdateEvent = {}
    
    init(eventID: NSManagedObjectID,
         navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let detailViewController = EventDetailViewController()
        let viewModel = EventDetailViewModel(eventID: eventID)
        viewModel.coordinator = self
        onUpdateEvent = {
            viewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        detailViewController.viewModel = viewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event,
                                                        navigationController: navigationController)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
