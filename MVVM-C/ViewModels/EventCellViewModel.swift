//
//  EventCellViewModel.swift
//  MVVM-C
//
//  Created by Pawel Kacela on 05/07/2021.
//

import UIKit

struct EventCellViewModel {
    
    var yearText: String {
        "1 year"
    }
    
    var monthText: String {
        "1 month"
    }
    
    var weekText: String {
        "1 week"
    }
    
    var dayText: String {
        "5 days"
    }
    
    var dateText: String {
        "25 march 2020"
    }
    
    var eventName: String {
        "Barbados"
    }
    
    var backgroundImage: UIImage {
        #imageLiteral(resourceName: "newyear")
    }
}
