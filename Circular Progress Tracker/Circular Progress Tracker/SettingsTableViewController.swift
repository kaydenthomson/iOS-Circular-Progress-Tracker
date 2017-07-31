//
//  SettingsTableViewController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/29/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

struct Section {
    var title: String!
    var time: Date!
    var expanded: Bool
    
    init(title: String, time: Date, expanded: Bool = false) {
        self.title = title
        self.time = time
        self.expanded = expanded
    }
}

class SettingsTableViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    var sections = [Section]()
    let dateFormatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "ExpandableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "timeHeaderCell")
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        sections = [
            Section(title: "Wake Time", time: dateFormatter.date(from: "6:30 AM")!),
            Section(title: "Sleep TIme", time: dateFormatter.date(from: "10:30 PM")!)
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].expanded ? 216 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "timeHeaderCell") as? ExpandableHeaderView else { return nil }
        header.title = sections[section].title
        header.detail = dateFormatter.string(from: sections[section].time)
        header.delegate = self
        header.section = section
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "timePickerCell")!
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: UITableViewRowAnimation.automatic)
    }
}
