//
//  EventCell.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 05/07/2021.
//

import UIKit


class EventCell: UITableViewCell {
    
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let weekLabel = UILabel()
    private let daysLabel = UILabel()
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [yearLabel,
         monthLabel,
         weekLabel,
         daysLabel,
         dateLabel,
         eventNameLabel,
         backgroundImageView,
         verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [yearLabel,
         monthLabel,
         weekLabel,
         daysLabel,
         dateLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            $0.textColor = .white
         }
        
        eventNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        verticalStackView.axis = .vertical
        
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        
        [yearLabel,
         monthLabel,
         weekLabel,
         daysLabel,
         dateLabel].forEach {
            verticalStackView.addSubview($0)
         }
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges()
        verticalStackView.pinToSuperviewEdges([.right, .bottom, .top], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
        yearLabel.text = viewModel.yearText
        monthLabel.text = viewModel.monthText
        weekLabel.text = viewModel.weekText
        daysLabel.text = viewModel.dayText
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        backgroundImageView.image = viewModel.backgroundImage
        
    }
}
