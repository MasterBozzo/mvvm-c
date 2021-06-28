//
//  TitleSubtitleCellViewModel.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 28/06/2021.
//

final class TitleSubtitleCellViewModel {
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    
    init(title: String, subtitle: String, placeholder: String) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
    }
}
