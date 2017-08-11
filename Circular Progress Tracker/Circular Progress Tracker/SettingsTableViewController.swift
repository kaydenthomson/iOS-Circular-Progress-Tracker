//
//  SettingsTableViewController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/29/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, ExpandableHeaderViewDelegate, TimePickerTableViewCellDelegate, ColorTableViewCellDelegate  {
    
    enum SettingCellType {
        case wakeTimePicker
        case sleepTimePicker
        case color(theme: ColorTheme, title: String)
    }
    
    enum SettingSectionType {
        case wakeTimeSection
        case sleepTimeSection
        case colorSection
    }
    
    struct Section {
        let sectionType: SettingSectionType
        let title: String!
        let detail: String!
        var expanded: Bool
        let cells: [SettingCellType]
        
        var numberOfRows: Int {
            return expanded ? cells.count : 0
        }
    }
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    var sections = [Section]()
    let dateFormatter = DateFormatter()
    var wakeTime: Date = Date()
    var sleepTime: Date = Date()
    
    var colorTheme: ColorTheme = .Blue {
        didSet {
            tableView.backgroundColor = colorTheme.Background
            guard let navBar = self.navigationController as? SettingNavigationController else {
                fatalError("SettingNavigationController was expected")
            }
            navBar.theme = colorTheme
            closeButton.tintColor = colorTheme.Primary
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UINib(nibName: "ExpandableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "timeHeaderCell")
        tableView.register(UINib(nibName: "TimePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "timePickerCell")
        
        let defaultWakeTime = "6:30 AM"
        let defaultSleepTime = "10:30 PM"
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        wakeTime = dateFormatter.date(from: defaultWakeTime)!
        sleepTime = dateFormatter.date(from: defaultSleepTime)!
        
        sections = [
            Section(sectionType: .wakeTimeSection, title: "Wake Time", detail: defaultWakeTime, expanded: false, cells: [.wakeTimePicker]),
            Section(sectionType: .sleepTimeSection, title: "Sleep Time", detail: defaultSleepTime, expanded: false, cells: [.sleepTimePicker]),
            Section(sectionType: .colorSection, title: "Theme Color", detail: "", expanded: true, cells: [.color(theme: .Blue, title: "Blue"), .color(theme:.Green, title: "Green"), .color(theme: .Pink, title: "Pink"), .color(theme: .Red, title: "Red")])
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
        return sections[indexPath.section].expanded ? 186 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "timeHeaderCell") as? ExpandableHeaderView else { return nil }
        header.title = sections[section].title
        header.delegate = self
        header.section = section
        header.backgroundView?.backgroundColor = colorTheme.Background
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = colorTheme.Background
        
        switch sections[section].sectionType {
        case .wakeTimeSection:
            header.detail = dateFormatter.string(from: wakeTime)
        case .sleepTimeSection:
            header.detail = dateFormatter.string(from: sleepTime)
        case .colorSection:
            header.detail = ""
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = settingCellAtIndexPath(indexPath)
        
        switch settingCell {
        case .wakeTimePicker:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell") as? TimePickerTableViewCell else { fatalError("TimePickerTableViewCell was expected") }
            cell.configure(indexPath: indexPath, currentDate: wakeTime, delegate: self)
            return cell
        case .sleepTimePicker:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell") as? TimePickerTableViewCell else { fatalError("TimePickerTableViewCell was expected") }
            cell.configure(indexPath: indexPath, currentDate: sleepTime, delegate: self)
            return cell
        case .color(let theme, let title):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell") as? ColorSettingTableViewCell else { fatalError("ColorSettingTableViewCell was expected") }
            
            cell.textLabel?.text = title
            cell.backgroundColor = colorTheme.Background
            cell.theme = theme
            cell.delegate = self
            
            if colorTheme == cell.theme {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
            
            return cell
        }
    }
    
   private func settingCellAtIndexPath(_ indexPath: IndexPath) -> SettingCellType {
        guard indexPath.section < sections.count else { fatalError("No section for Paths component") }
        
        let section = sections[indexPath.section]
        
        guard indexPath.row < section.cells.count else { fatalError("No row for Paths component") }
        
        let pathCell = section.cells[indexPath.row]
        
        return pathCell
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: UITableViewRowAnimation.automatic)
    }
    
    func selectColor(colorCell: ColorSettingTableViewCell, theme: ColorTheme) {
        colorTheme = theme
    }
    
    func timeChangedForField(indexPath: IndexPath, toTime: Date) {
        let settingCell = settingCellAtIndexPath(indexPath)
        
        switch settingCell {
        case .wakeTimePicker:
            self.wakeTime = toTime
        case .sleepTimePicker:
            self.sleepTime = toTime
        case .color:
            break
        }
        
        self.tableView.reloadData()
    }
}
