//
//  ActivityCell.swift
//  BoredApp
//
//  Created by hungdat1234 on 3/30/22.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    // MARK: - OUTLET
    @IBOutlet private weak var activityLbl: UILabel!
    @IBOutlet private weak var accessibilityLbl: UILabel!
    @IBOutlet private weak var participantsLbl: UILabel!

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
        
        activityLbl.text = ""
        accessibilityLbl.text = ""
        participantsLbl.text = ""
    }
    
    func bindData(_ viewModel: ActivityViewModel) {
        activityLbl.text = viewModel.getActivity()
        accessibilityLbl.text = viewModel.getAccessibility()
        participantsLbl.text = viewModel.getParticipants()
    }
    
}
