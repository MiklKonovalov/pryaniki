//
//  DataService.swift
//  Pryaniky_test
//
//  Created by Misha on 26.05.2022.
//

import Foundation
import UIKit

class DataService {
    
    var datum: [Datum] = []
    
    func getData(callBack: @escaping () -> Void?) {
        
        let urlString = "https://pryaniky.com/static/json/sample.json"
        
        guard let url = URL(string: urlString) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                self?.datum = jsonResult.data
                callBack()
            }
            catch {
                print(error)
            }
            
        }
        task.resume()
    }
}
