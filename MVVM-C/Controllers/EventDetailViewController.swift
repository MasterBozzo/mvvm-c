//
//  EventDetailViewController.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 07/07/2021.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    var viewModel: EventDetailViewModel!
    
    let backgroundImage = UIImageView()
    let timeRemainingStackView = TimeRemainingStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self,
                  let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImage.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        setupViews()
        setupHierarchy()
        setupLayout()
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func setupViews() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        timeRemainingStackView.setup()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(timeRemainingStackView)
    }
    
    private func setupLayout() {
        backgroundImage.pinToSuperviewEdges()
        
        NSLayoutConstraint.activate([
            timeRemainingStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeRemainingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    

}
