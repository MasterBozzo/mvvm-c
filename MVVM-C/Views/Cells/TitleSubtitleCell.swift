//
//  TitleSubtitleCell.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 28/06/2021.
//
import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    let constant: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 44))
    lazy var doneButton: UIBarButtonItem = {
     return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView = UIImageView()
    
    private var viewModel: TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        photoImageView.image = viewModel.image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        [verticalStackView, titleLabel, subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        toolbar.setItems([doneButton], animated: false)
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: constant),
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func tappedDone() {
        viewModel?.update(datePickerView.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
