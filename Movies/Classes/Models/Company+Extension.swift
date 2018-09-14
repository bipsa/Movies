//
//  Company+Extension.swift
//  Movies
//
//  Created by Sebastian Romero on 14/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

extension Company {
    
    
    class func add(companyItem:ProductionCompanies) -> Company {
        var company:Company! = Company.get(attribute: "id", value: "=\(companyItem.id)")
        if company == nil {
            company = Company.create()
        }
        company.id = companyItem.id
        if let path = companyItem.logo_path {
            company.logo = path
        }
        company.name = companyItem.name
        company.country = companyItem.origin_country
        _ = company.save()
        return company
    }
    
}
