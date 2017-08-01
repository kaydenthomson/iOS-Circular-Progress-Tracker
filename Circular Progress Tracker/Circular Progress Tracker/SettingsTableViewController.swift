//
//  SettingsTableViewController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/29/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, ExpandableHeaderViewDelegate {
    
    enum SettingCell {
        case timePicker
        case color(title: String, selected: Bool)
    }
    
    enum SectionType {
        case timeSection
        case colorSection
    }
    
    struct Section {
        let sectionType: SectionType
        let title: String!
        let detail: String!
        var expanded: Bool
        let cells: [SettingCell]
        
        var numberOfRows: Int {
            return expanded ? cells.count : 0
        }
    }
    
    var sections = [Section]()
    let dateFormatter = DateFormatter()
    var colorTheme: ColorTheme = .Blue
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "ExpandableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "timeHeaderCell")
        tableView.backgroundColor = colorTheme.Background
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        sections = [
            Section(sectionType: .timeSection, title: "Wake Time", detail: "6:30 AM", expanded: false, cells: [.timePicker]),
            Section(sectionType: .timeSection, title: "Sleep Time", detail: "10:30 PM", expanded: false, cells: [.timePicker]),
            Section(sectionType: .colorSection, title: "Theme Color", detail: "", expanded: true, cells: [.color(title: "Blue", selected: true), .color(title: "Green", selected: false), .color(title: "Pink", selected: false), .color(title: "Red", selected: false)])
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].sectionType == .colorSection { return 44 }
        return sections[indexPath.section].expanded ? 216 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "timeHeaderCell") as? ExpandableHeaderView else { return nil }
        header.title = sections[section].title
        header.detail = sections[section].detail
        header.delegate = self
        header.section = section
        header.backgroundView?.backgroundColor = colorTheme.Background
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = colorTheme.Background
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = settingCellAtIndexPath(indexPath)
        
        switch settingCell {
        case .timePicker:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell") else { fatalError("UITableViewCell was expected") }
//            let datepicker = UIDatePicker()
//            datepicker.datePickerMode = .time
//            datepicker.setValue(UIColor.white, forKey: "textColor")
//            cell.addSubview(datepicker)
            cell.backgroundColor = colorTheme.Background
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        case .color(let title, let selected):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell") else { fatalError("UITableViewCell was expected") }
            cell.textLabel?.text = title
            if selected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            cell.backgroundColor = colorTheme.Background
            
            switch title {
            case "Blue":
                cell.textLabel?.textColor = ColorTheme.Blue.Primary
            case "Green":
                cell.textLabel?.textColor = ColorTheme.Green.Primary
            case "Pink":
                cell.textLabel?.textColor = ColorTheme.Pink.Primary
            case "Red":
                cell.textLabel?.textColor = ColorTheme.Red.Primary
            default:
                cell.textLabel?.textColor = UIColor.white
            }
            
            return cell
        }
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: UITableViewRowAnimation.automatic)
    }
    
    func settingCellAtIndexPath(_ indexPath: IndexPath) -> SettingCell {
        guard indexPath.section < sections.count else { fatalError("No section for Paths component") }
        
        let section = sections[indexPath.section]
        
        guard indexPath.row < section.cells.count else { fatalError("No row for Paths component") }
        
        let pathCell = section.cells[indexPath.row]
        
        return pathCell
    }
}
