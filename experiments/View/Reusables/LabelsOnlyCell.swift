//
//  LabelsOnlyCell.swift
//  experiments
//
//  Created by Mariah Jessica Baysic on 7/12/21.
//

import UIKit

class LabelsOnlyCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(title: String, body: String) {
        self.title.text = title
        self.body.text = body
    }

}
