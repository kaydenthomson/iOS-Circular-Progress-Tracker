//
//  ExpandableHeaderView.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 7/28/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var detail: String? {
        didSet {
            detailLabel.text = detail
        }
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title = nil
        detail = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
}
