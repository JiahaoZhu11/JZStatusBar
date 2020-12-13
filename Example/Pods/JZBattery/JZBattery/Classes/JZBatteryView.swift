//
//  JZBattery.swift
//  JZBattery
//
//  Created by Jiahao Zhu on 2020/12/11.
//

import UIKit

fileprivate let standardWidth: CGFloat = 25

@IBDesignable

public class JZBatteryView: UIView {
    
    public enum ColorStyle {
        case light, dark
    }
    
    /// 电池状态改变回调
    public var batteryStateChangeCallback: ((UIDevice.BatteryState) -> ())?
    
    /// 电池电量改变回调
    public var batteryLevelChangeCallback: ((Float) -> ())?
    
    /// 当前电池状态
    public var currentBatteryState: UIDevice.BatteryState {
        get {
            return batteryState
        }
    }
    
    /// 当前电池电量
    public var currentBatteryLevel: Float {
        get {
            return batteryLevel
        }
    }
    
    /// 配色风格
    public var style: ColorStyle = .dark {
        didSet {
            switch style {
            case .light:
                borderColor = .black
                fillingColor = .black
            case .dark:
                borderColor = .white
                fillingColor = .white
            }
        }
    }
    
    /// 宽高比
    public var widthToHeightRatio: CGFloat = 2.5 {
        didSet {
            drawBattery()
        }
    }
    
    private lazy var batteryBodyLayer: CAShapeLayer = {
        let layer = CAShapeLayer(layer: self.layer)
        layer.strokeColor = borderColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private lazy var batteryNodeLayer: CAShapeLayer = {
        let layer = CAShapeLayer(layer: self.layer)
        layer.strokeColor = borderColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    private lazy var batteryFillingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var width: CGFloat = 0
    
    private var height: CGFloat = 0
    
    private var origin: CGPoint = CGPoint.zero
    
    private var borderColor: UIColor = .white
    
    private var fillingColor: UIColor = .white
    
    private var batteryState: UIDevice.BatteryState = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryState = UIDevice.current.batteryState
        return batteryState
    }() {
        didSet {
            updateBatteryStatus()
        }
    }
    
    private var batteryLevel: Float = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = UIDevice.current.batteryLevel
        return batteryLevel
    }() {
        didSet {
            batteryFillingView.frame.size.width = (width - 2) * CGFloat(batteryLevel)
            updateBatteryStatus()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBatteryStatus()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initBatteryStatus()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        drawBattery()
    }
    
    private func drawBattery() {
        width = frame.width - 6
        height = min(frame.height - 2, width / widthToHeightRatio)
        let scale = width / standardWidth
        origin = CGPoint(x: 2, y: (frame.height - height) / 2)
        
        /// 电池左侧
        let leftPath = UIBezierPath(roundedRect: CGRect(x: origin.x, y: origin.y, width: width, height: height), cornerRadius: 2 * scale)
        batteryBodyLayer.lineWidth = scale
        batteryBodyLayer.path = leftPath.cgPath
        
        // 电池右侧
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint(x: origin.x + width + scale, y: origin.y + height / 3))
        rightPath.addLine(to: CGPoint(x: origin.x + width + scale, y: origin.y + 2 * height / 3))
        batteryNodeLayer.lineWidth = 2 * scale
        batteryNodeLayer.path = rightPath.cgPath
        
        // 电池填充
        batteryFillingView.frame = CGRect(x: origin.x + scale, y: origin.y + scale, width: (width - 2 * scale) * CGFloat(batteryLevel), height: height - 2 * scale)
        batteryFillingView.layer.cornerRadius = scale
    }
    
    private func initBatteryStatus() {
        layer.addSublayer(batteryBodyLayer)
        layer.addSublayer(batteryNodeLayer)
        addSubview(batteryFillingView)
        observeBatteryStatus()
        batteryState = UIDevice.current.batteryState
    }
    
    private func observeBatteryStatus() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryLevel), name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryState), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
    }
    
    private func updateBatteryStatus() {
        switch batteryState {
        case .charging, .full:
            batteryFillingView.backgroundColor = .green
        case .unplugged:
            if batteryLevel < 0.2 {
                batteryFillingView.backgroundColor = .red
            } else {
                batteryFillingView.backgroundColor = fillingColor
            }
        default:
            batteryFillingView.backgroundColor = .clear
        }
    }
    
    @objc private func updateBatteryState() {
        batteryState = UIDevice.current.batteryState
        batteryStateChangeCallback?(batteryState)
    }
    
    @objc private func updateBatteryLevel() {
        batteryLevel = UIDevice.current.batteryLevel
        batteryLevelChangeCallback?(batteryLevel)
    }
}
