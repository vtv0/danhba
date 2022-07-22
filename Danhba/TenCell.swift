//
//  TenCell.swift
//  Danhba
//
//  Created by Vuong The Vu on 20/07/2022.
//

import UIKit

class TenCell: UITableViewCell {
    
    let tenLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    let categoryLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14 , weight: .bold)
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    override init (style: UITableViewCell.CellStyle , reuseIdentifier reuseIndentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIndentifier)
        
        addSubview(tenLbl)
        addSubview(categoryLbl)
        
        tenLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tenLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        tenLbl.rightAnchor.constraint(equalTo: categoryLbl.leftAnchor).isActive = true
        tenLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        categoryLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        categoryLbl.widthAnchor.constraint(equalToConstant: 120).isActive = true
        categoryLbl.rightAnchor.constraint(equalTo: rightAnchor, constant:  -20).isActive = true
        categoryLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    required init?(coder aDeccoder : NSCoder) {
        fatalError("init(coder:)  has not been implementted ")
    }

    
    
    
}
