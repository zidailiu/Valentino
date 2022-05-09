//
//  VLFormTableViewCell.swift
//  Valentino
//
//  Created by Liu John on 2022-03-16.
//

import UIKit

protocol VLFormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell:VLFormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class VLFormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "VLFormTableViewCell"
    
    public weak var delegate: VLFormTableViewCellDelegate?
    
    private var model: EditProfileFormModel?
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width/3, height: contentView.frame.size.height)
        field.frame = CGRect(x: formLabel.frame.origin.x + formLabel.frame.size.width + 5, y: 0, width: contentView.frame.size.width - 10 - formLabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    // MARK: - Field
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
    
    

}
