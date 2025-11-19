//
//  TrainTagButton.swift
//  KORAILTALK-iOS
//
//  Created by 어재선 on 11/18/25.
//

import UIKit

final class TrainTagButton: UIButton {
    
    
    var type: TrainTagType {
        didSet {
            updateStyle()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    init(type: TrainTagType, isSelected: Bool = false) {
        self.type = type
        super.init(frame: .zero)
        self.isSelected = isSelected
        setLayout()
        updateStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        config.cornerStyle = .fixed
        config.background.cornerRadius = 4
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
            var outgoing = incoming
            outgoing.font = .body2_m_15
            return outgoing
        }
        self.configuration = config
    }
    
    private func updateStyle() {
        var config = self.configuration ?? UIButton.Configuration.filled()
        config.title = type.title
        
        let style = type.style(isSelected: self.isSelected)
        
        config.baseForegroundColor = style.titleColor
        config.background.backgroundColor = style.backgroundColor
    
        if let borderColor = style.borderColor {
            config.background.strokeColor = borderColor
            config.background.strokeWidth = 1
        } else {
            config.background.strokeColor = .clear
            config.background.strokeWidth = 0
        }

        self.configuration = config
        
    }
}
