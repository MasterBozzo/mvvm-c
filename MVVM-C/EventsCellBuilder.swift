//
//  EventsCellBuilder.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 01/07/2021.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType,
                                        onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(title: "Name",
                                              subtitle: "",
                                              placeholder: "Add a name",
                                              type: .text,
                                              onCellUpdate: onCellUpdate
                                              )
        case .date:
            return TitleSubtitleCellViewModel(title: "Date",
                                              subtitle: "",
                                              placeholder: "Select a name",
                                              type: .date,
                                              onCellUpdate: onCellUpdate
                                              )
        case .image:
            return TitleSubtitleCellViewModel(title: "Background",
                                              subtitle: "",
                                              placeholder: "Select a name",
                                              type: .image,
                                              onCellUpdate: onCellUpdate
                                              )
        }
        
    }
}
