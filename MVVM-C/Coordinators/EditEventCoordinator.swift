//
//  EditEventCoordinator.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 08/07/2021.
//

import UIKit

final class EditEventCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    private var completion: (UIImage) -> Void  = { _ in }
    private let event: Event
    
    var parentCoordinator: EventDetailCoordinator?
    
    init(event: Event,
         navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        
        let editEventViewController = EditEventViewController()
        let editEventViewModel = EditEventViewModel(event: event,
                                                    cellBuilder: EventsCellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
        
        
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishUpdateEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
         
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    deinit {
        print("deinit from AddEventCoordinator")
    }
    
}
