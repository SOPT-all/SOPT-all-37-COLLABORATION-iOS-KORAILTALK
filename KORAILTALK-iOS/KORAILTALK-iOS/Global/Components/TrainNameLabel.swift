//
//  TrainName.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/20/25.
//

import UIKit

final class TrainNameLabel: UILabel {
    
    var trainName: TrainNameType
    var isDisabled: Bool{
        didSet {
            self.setStyle()
        }
    }
    
    private let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    init(trainName: TrainNameType, isDisabled: Bool = true) {
        self.trainName = trainName
        self.isDisabled = isDisabled
        super.init(frame: .zero)
        self.setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    func setStyle() {
        text = trainName.title
        layer.backgroundColor = trainName.backgroundColor(isDisabled: isDisabled).cgColor
        layer.cornerRadius = 4
        textAlignment = .center
        textColor = .mainWhite
        font = .body4_m_14
    }
}
