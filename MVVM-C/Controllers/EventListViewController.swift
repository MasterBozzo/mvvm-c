//
//  EventListViewController.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 24/06/2021.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let rightButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        rightButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
    
    
}
