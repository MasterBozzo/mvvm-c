//
//  EditEventViewModel.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 08/07/2021.
//

import UIKit

final class EditEventViewModel {
    
    let title = "Edit"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [EditEventViewModel.Cell] = []
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    private let cellBuilder: EventsCellBuilder
    private let coreDataManager: CoreDataManager
    private let event: Event
    
    lazy var dateForamtter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    init(event: Event,
         cellBuilder: EventsCellBuilder,
         coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
        self.event = event
    }
    
    func viewDidLoad() {
        
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
       return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let image = backgroundImageCellViewModel?.image,
              let date = dateForamtter.date(from: dateString) else { return }
        
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleModelView):
            guard titleSubtitleModelView.type == .image else {
                return
            }
            coordinator?.showImagePicker { image in
                titleSubtitleModelView.update(image)
            }
        }
    }
    
    deinit {
        print("deinit from AddEventViewModel")
    }
}

private extension EditEventViewModel {
    
    private func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel =  cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self ] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self ] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel,
              let dateCellViewModel = dateCellViewModel,
              let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        
        cells = [
            .titleSubtitle(
                nameCellViewModel
            ),
            .titleSubtitle(
                dateCellViewModel
            ),
            .titleSubtitle(
                backgroundImageCellViewModel
            )
        ]
        
        guard let name = event.name,
              let date = event.date,
              let imageData = event.image,
              let image = UIImage(data: imageData) else { return }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundImageCellViewModel.update(image)
    }
}

