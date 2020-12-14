//
//  JZStatusBar.swift
//  JZStatusBar
//
//  Created by Jiahao Zhu on 2020/12/11.
//

import UIKit
import AFNetworking
import CoreTelephony
import JZBattery

// @IBDesignable

public class JZStatusBar: UIView {
    
    @IBOutlet private weak var internetStatusLabel: UILabel!
    
    @IBOutlet private weak var timeLabel: UILabel!

    @IBOutlet private weak var batteryLabel: UILabel!
    
    @IBOutlet private weak var batteryView: JZBatteryView!
    
    private var statusBar: UIView?
    
    private var networkStatus: AFNetworkReachabilityStatus = AFNetworkReachabilityManager.shared().networkReachabilityStatus {
        didSet {
            updateInternetStatus()
        }
    }
    
    private var networkInfo = CTTelephonyNetworkInfo().currentRadioAccessTechnology {
        didSet {
            updateInternetStatus()
        }
    }
    
    private let WWANString: [String: String]
    
    public override init(frame: CGRect) {
        if #available(iOS 14.0, *) {
            WWANString = ["": "未知",
                          CTRadioAccessTechnologyGPRS: "2G",
                          CTRadioAccessTechnologyEdge: "2G",
                          CTRadioAccessTechnologyCDMA1x: "2G",
                          CTRadioAccessTechnologyWCDMA: "3G",
                          CTRadioAccessTechnologyHSDPA: "3G",
                          CTRadioAccessTechnologyHSUPA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORev0: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevB: "3G",
                          CTRadioAccessTechnologyeHRPD: "3G",
                          CTRadioAccessTechnologyLTE: "4G",
                          CTRadioAccessTechnologyNRNSA: "5G",
                          CTRadioAccessTechnologyNR: "5G"]
        } else {
            WWANString = ["": "未知",
                          CTRadioAccessTechnologyGPRS: "2G",
                          CTRadioAccessTechnologyEdge: "2G",
                          CTRadioAccessTechnologyCDMA1x: "2G",
                          CTRadioAccessTechnologyWCDMA: "3G",
                          CTRadioAccessTechnologyHSDPA: "3G",
                          CTRadioAccessTechnologyHSUPA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORev0: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevB: "3G",
                          CTRadioAccessTechnologyeHRPD: "3G",
                          CTRadioAccessTechnologyLTE: "4G"]
        }
        super.init(frame: frame)
        statusBar = Bundle(for: JZStatusBar.self).loadNibNamed("JZStatusBar", owner: self, options: nil)?.first as? UIView
        if let statusBar = statusBar {
            addSubview(statusBar)
            initStatusBar()
        }
    }
    
    required init?(coder: NSCoder) {
        if #available(iOS 14.0, *) {
            WWANString = ["": "未知",
                          CTRadioAccessTechnologyGPRS: "2G",
                          CTRadioAccessTechnologyEdge: "2G",
                          CTRadioAccessTechnologyCDMA1x: "2G",
                          CTRadioAccessTechnologyWCDMA: "3G",
                          CTRadioAccessTechnologyHSDPA: "3G",
                          CTRadioAccessTechnologyHSUPA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORev0: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevB: "3G",
                          CTRadioAccessTechnologyeHRPD: "3G",
                          CTRadioAccessTechnologyLTE: "4G",
                          CTRadioAccessTechnologyNRNSA: "5G",
                          CTRadioAccessTechnologyNR: "5G"]
        } else {
            WWANString = ["": "未知",
                          CTRadioAccessTechnologyGPRS: "2G",
                          CTRadioAccessTechnologyEdge: "2G",
                          CTRadioAccessTechnologyCDMA1x: "2G",
                          CTRadioAccessTechnologyWCDMA: "3G",
                          CTRadioAccessTechnologyHSDPA: "3G",
                          CTRadioAccessTechnologyHSUPA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORev0: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevA: "3G",
                          CTRadioAccessTechnologyCDMAEVDORevB: "3G",
                          CTRadioAccessTechnologyeHRPD: "3G",
                          CTRadioAccessTechnologyLTE: "4G"]
        }
        super.init(coder: coder)
        statusBar = Bundle(for: JZStatusBar.self).loadNibNamed("JZStatusBar", owner: self, options: nil)?.first as? UIView
        if let statusBar = statusBar {
            addSubview(statusBar)
            initStatusBar()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        statusBar?.frame = bounds
    }
    
    private func initStatusBar() {
        observeNetworkStatus()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = formatter.string(from: Date())
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
                self?.timeLabel.text = formatter.string(from: Date())
            }
        } else {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action(timer:)), userInfo: { [weak self] (timer: Timer) in
                self?.timeLabel.text = formatter.string(from: Date())
            }, repeats: true)
        }
        
        batteryView.batteryLevelChangeCallback = { [weak self] (level) in
            self?.batteryLabel.text = "\(Int(level * 100))%"
        }
        batteryLabel.text = "\(Int(batteryView.currentBatteryLevel * 100))%"
    }
    
    private func observeNetworkStatus() {
        if #available(iOS 12.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(updateNetworkInfo), name: NSNotification.Name.CTServiceRadioAccessTechnologyDidChange, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(updateNetworkInfo), name: NSNotification.Name.CTRadioAccessTechnologyDidChange, object: nil)
        }
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { [weak self] (status) in
            self?.networkStatus = status
        }
        AFNetworkReachabilityManager.shared().startMonitoring()
    }
    
    private func updateInternetStatus() {
        switch networkStatus {
        case .notReachable:
            internetStatusLabel.text = "无网络"
        case .reachableViaWWAN:
            internetStatusLabel.text = WWANString[networkInfo ?? ""]
        case .reachableViaWiFi:
            internetStatusLabel.text = "Wi-Fi"
        default:
            internetStatusLabel.text = "未知"
        }
    }
    
    @objc private func updateNetworkInfo() {
        networkInfo = CTTelephonyNetworkInfo().currentRadioAccessTechnology
    }
    
    @objc private func action(timer: Timer) {
        guard let block = timer.userInfo as? ((Timer) -> ()) else {
            return
        }
        block(timer);
    }
    
}
