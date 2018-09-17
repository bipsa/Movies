//
//  CreditsCell.swift
//  Movies
//
//  Created by Sebastian Romero on 17/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit

class CreditsCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentCredits:[Credit] = []
    
    var credits:[Credit] {
        get {
            return currentCredits
        }
        set {
            currentCredits = newValue
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: "CreditCell", bundle: nil), forCellReuseIdentifier: "CreditCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension CreditsCell {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        let credit = credits[indexPath.row]
        let creditsCell = tableView.dequeueReusableCell(withIdentifier: "CreditCell", for: indexPath as IndexPath) as! CreditCell
        creditsCell.credit = credit
        creditsCell.backgroundColor = .clear
        cell = creditsCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
