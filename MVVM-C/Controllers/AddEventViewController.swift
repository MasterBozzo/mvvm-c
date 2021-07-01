//
//  AddEvenViewController.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 25/06/2021.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var viewModel: AddEventViewModel!
    var sharedView = AddEventView()
    
    override func loadView() {
        view = sharedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel.onUpdate = { [weak self] in
            self?.sharedView.tableView.reloadData()
        }
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewModel.viewDidDisappear()
    }
    
    @objc func tappedDone() {
        viewModel.tappedDone()
    }
    
    private func setupViews() {
        sharedView.tableView.dataSource = self
        sharedView.tableView.delegate = self
        sharedView.tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
        sharedView.tableView.tableFooterView = UIView()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .black
        // to force large titles
        navigationItem.largeTitleDisplayMode = .always
        sharedView.tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
    }
    
    deinit {
        print("deinit from AddEventViewController")
    }
}

extension AddEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubtitleCell", for: indexPath) as! TitleSubtitleCell
            cell.update(with: titleSubtitleCellViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        }
    }
    
}

extension AddEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


extension AddEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin, to: sharedView.tableView)
        if let indexPath = sharedView.tableView.indexPathForRow(at: point) {
            viewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        return true
    }
}
