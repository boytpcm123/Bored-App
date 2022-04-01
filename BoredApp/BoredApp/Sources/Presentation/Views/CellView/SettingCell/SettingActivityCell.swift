//
//  SettingActivityCell.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/1/22.
//

import UIKit

class SettingActivityCell: UITableViewCell {

    // MARK: - OUTLET
    @IBOutlet private weak var activityTypeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.autoresizingMask = .flexibleHeight
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityTypeLbl.text = ""
        self.accessoryType = .none
    }
    
    func bindData(_ viewModel: ActivitySettingViewModel) {
        activityTypeLbl.text = viewModel.getNameActivity()
        self.accessoryType = viewModel.getStateSelected() ? .checkmark : .none
    }
    
}
