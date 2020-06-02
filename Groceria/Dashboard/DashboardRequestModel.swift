//
//  DashboardRequestModel.swift
//  Groceria
//
//  Created by Angela Luo on 5/30/20.
//  Copyright © 2020 Angela Luo. All rights reserved.
//

import Foundation
import UIKit


class DashboardRequestModel {
    var nameOfPerson: String
    var numberOfItems: Int
    var store: String?
    
    var items: [ShoppingItem]
    
    init(name: String, numberOfItems: Int, items: [ShoppingItem]) {
        self.nameOfPerson = name
        self.numberOfItems = numberOfItems
        self.items = items
    }
    
    
    struct ShoppingItem: Identifiable {
        var id: UUID
        var title: String
        var extraInfo: String?
        var picture: UIImage?
        var checked = false
        
        init(title: String, extraInfo: String? = nil, picture: UIImage? = nil) {
            self.id = UUID()
            self.title = title
            self.extraInfo = extraInfo
            self.picture = picture
        }
        
        mutating func toggleChecked() {
            self.checked.toggle()
        }
    }
}