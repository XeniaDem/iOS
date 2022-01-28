//
//  CustomButton.swift
//  kvdemidenkoPW7
//
//  Created by Ксения Демиденко on 28.01.2022.
//

import UIKit

final class CustomButton : UIButton {
    private let title: UILabel = {
        let label = UILabel()
        return label
    }()
    let viewModel: CustomButtonViewModel?
    
    init(with viewModel : CustomButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        title.text = viewModel.title
        title.textColor = viewModel.textColor
        backgroundColor = viewModel.backgroundColor
        setTitle(viewModel.title, for: .normal)
        setTitleColor(viewModel.textColor, for: .normal)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct CustomButtonViewModel {
    let title: String
    let backgroundColor: UIColor
    let textColor: UIColor
    
}
