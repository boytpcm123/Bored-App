//
//  ActivityHeaderCellView.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/31/22.
//

import UIKit

class ActivityHeaderCellView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var typeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        typeLbl.text = ""
    }
    
    func bindData(_ nameType: String) {
        typeLbl.text = nameType
    }
}
