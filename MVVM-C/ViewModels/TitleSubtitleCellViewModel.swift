//
//  TitleSubtitleCellViewModel.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 28/06/2021.
//
import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    private(set) var image: UIImage?
    var onCellUpdate: () -> Void = {}
    
    init(title: String, subtitle: String, placeholder: String, type: CellType, onCellUpdate: @escaping () -> Void ) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate()
    }
}
