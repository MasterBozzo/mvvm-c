//
//  AddEventViewModel.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 25/06/2021.
//

import UIKit

final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                TitleSubtitleCellViewModel(title: "Name", subtitle: "", placeholder: "Add a name", type: .text, onCellUpdate: {})
            ),
            .titleSubtitle(
                TitleSubtitleCellViewModel(title: "Date", subtitle: "", placeholder: "Select a name", type: .date, onCellUpdate: { [weak self] in
                    self?.onUpdate()
                })
            ),
            .titleSubtitle(
                TitleSubtitleCellViewModel(title: "Background", subtitle: "", placeholder: "Select a name", type: .image, onCellUpdate: { [weak self] in
                    self?.onUpdate()
                })
            )
        ]
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
       return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        print("tapped done")
        //extract infor form cell view model and save to core data
        //tell coordinator to dismiss
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
