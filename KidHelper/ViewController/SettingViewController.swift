//
//  SettingViewController.swift
//  KidHelper
//
//  Created by Liu PingAn on 28/02/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableToplayout: NSLayoutConstraint!
    
    var datasource : [SectionDataM] = []
    enum SectionTitle:String {
        case YU_WEN = "语文"
    }
    enum Action:String {
        case MO_XIE = "听写"
        case GUAN_YU = "关于"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = true
        
        datasource = buildDataSource()

        initTableView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 20))
        let labelView = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 20))
        labelView.text = datasource[section].title
        labelView.font = UIFont.systemFont(ofSize: 15)
        labelView.textColor = UIColor.darkText
        view.addSubview(labelView)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = datasource[section]
        return sectionData.cells.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "tableCell"
//        let cellView:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        var cellView:UITableViewCell? =
            tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cellView == nil)
        {
            cellView = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: identifier)
        }
        
        let _celldata = cellData(cellDataForRowAt: indexPath)
         
        cellView!.textLabel?.text = _celldata.title
        cellView!.detailTextLabel?.text = _celldata.subtitle

        cellView!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cellView!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let _cellData = cellData(cellDataForRowAt: indexPath)
        print(_cellData)
        
        var vc :UIViewController?
        if _cellData.title == Action.MO_XIE.rawValue {
            let className = String(describing: TextInputContrViewController.self)
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className)
            if (vc is TextInputContrViewController)
            {
                let vcc:TextInputContrViewController = vc as! TextInputContrViewController
                // 防止循环引用
                weak var ws = self
                vcc.title = _cellData.title
                vcc.text = _cellData.subtitle
                vcc.onTextChangedCallback = { (text) -> () in
                    print("------\(text)")
                    _cellData.subtitle = text
                    ws?.tableView.reloadData()
                }
            }
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func cellData(cellDataForRowAt indexPath: IndexPath) -> CellDataM
    {
        let sectionData = datasource[indexPath.section]
        return sectionData.cells[indexPath.row]
    }
    
    func initTableView() -> Void {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.sectionIndexBackgroundColor = UIColor.lightGray
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    func buildDataSource() -> [SectionDataM] {
       
        let secData:SectionDataM = SectionDataM()
        secData.title = SectionTitle.YU_WEN.rawValue
        
        let cellData = CellDataM()
        cellData.title = Action.MO_XIE.rawValue
        if let text = DataProvider.readFromiCloud(KeyConstant.MO_XIE.rawValue) {
             cellData.subtitle = text
        }
        secData.cells.append(cellData)
        
        var dataSource = [SectionDataM]()
        dataSource.append(secData)
        
        return dataSource
    }

}

