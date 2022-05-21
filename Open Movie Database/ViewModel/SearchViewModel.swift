//
//  SearchViewModel.swift
//  Open Movie Database
//
//  Created by Chandresh Kachariya on 03/06/21.
//

import Foundation

class SearchViewModel {
    
    public var searchResultList: SearchResultModel? = nil
    
    func fetchSearchResults(_ searchString: String, apikey:String, page: Int, completion: @escaping (_ result : String) -> Void, failure: @escaping (_ result : String) -> Void) {
        
        let searchStringValue = searchString.removeExtraSpaces()
        
        let dict = ["s" : searchStringValue,
                    "page": page,
                    "apikey": apikey
        ] as [String : Any]
        
        APIManager.shared.makeRequest(url: "/", params: dict, withHttpMethod: .get) { (result: SearchResultModel?) in
            if result?.response == "True" {
                self.searchResultList = nil
                self.searchResultList = result
                completion(Key.API.status.success.rawValue)
            } else {
                failure("Data not found")
            }
        }
        failure: { (error) in
            if let errorValue = error as? String {
                print(errorValue)
                failure(errorValue)
            }
        }
    }
}

extension String {
    public func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil).trimmingCharacters(in: .whitespaces)
    }
}

