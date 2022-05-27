//
//  ViewModel.swift
//  Pryaniky_test
//
//  Created by Misha on 26.05.2022.
//

import Foundation

class ViewModel {
    
    let dataService: DataService
    var viewModelDidChange: (() -> Void)?
    var nameLabel: String?
    var selectorArray: [Int] = []
    var imageURL: URL?
    
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func getDataFromViewModel() {

        dataService.getData {
            DispatchQueue.main.async {
                self.nameLabel = self.dataService.datum.first?.name
                
                self.selectorArray.append(self.dataService.datum[2].data.variants?.first?.id ?? 0)
                self.selectorArray.append(self.dataService.datum[2].data.variants?[1].id ?? 0)
                self.selectorArray.append(self.dataService.datum[2].data.variants?[2].id ?? 0)
                
                self.imageURL = URL(string: self.dataService.datum[1].data.url ?? "No value")
                self.viewModelDidChange?()
            }
        }
    }
    
    
}
