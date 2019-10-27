//
//  TextInputValidator.swift
//  SearchMusic
//
//  Created by Yaroslav Zakharchuk on 9/14/19.
//  Copyright © 2019 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

protocol TextInputVerifiable {
    func isValid(searchText: String?) -> SearchTextVerificationResult
}

enum SearchTextVerificationResult {
    case success(_ searchData: SearchData)
    case error(_ err: ValidationError)
}

struct TextInputValidator {
    
    private let filterString = " [-:|\\//~] "
}

// MARK: - TextInputVerifiable
extension TextInputValidator: TextInputVerifiable {

    func isValid(searchText: String?) -> SearchTextVerificationResult {
        guard let searchText = searchText else {
            return .error(ValidationError(name: "Error", message: "Blank search field"))
        }
        
        guard !searchText.isEmpty else {
            return .error(ValidationError(name: "Error", message: "Search field is empty"))
        }
        
        if let substrRange = searchText.range(of: " [-:|\\//~] ", options: .regularExpression) {
            let separatedSymbol = String(describing: searchText[substrRange])
            let tmp = searchText.components(separatedBy: separatedSymbol)
            
            if tmp[0].isEmpty {
                return .error(ValidationError(name: "Error", message: "Enter artist name"))
            } else if tmp[1].isEmpty {
                return .error(ValidationError(name: "Error", message: "Enter track name"))
            }
            return .success(SearchData(albumName: tmp[1], artistName: tmp[0]))
        } else {
            return .error(ValidationError(name: "Incorrect search format", message: "Please enter: artist separating symbols: (‘-‘, ‘:’, ‘|’, ‘\\’, ‘/‘, ‘~’) and track"))
        }
    }
}
