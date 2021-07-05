//
//  EventListViewController.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 24/06/2021.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    var sharedView = EventListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel.onUpdate = { [weak self] in
            self?.sharedView.tableView.reloadData()
        }
        
        viewModel.viewDidLoad()
    }
    
    override func loadView() {
        view = sharedView
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let rightButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        rightButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        sharedView.tableView.dataSource = self
        sharedView.tableView.register(EventCell.self, forCellReuseIdentifier: "eventCell")
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
    
}

extension EventListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
}
