import UIKit

class CustomCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var category = UILabel()
    
    var amount = UILabel()
    
    private var arrowButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureAmountView()
        configureCategoryView()
    }
    
    private func addSubviews () {
        addSubview(category)
        addSubview(amount)
        addSubview(arrowButton)
    }
    
    private func configureCategoryView () {
        category.font = UIFont.systemFont(ofSize: 14)
        category.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-133)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureAmountView () {
        amount.font = UIFont.systemFont(ofSize: 14)
        amount.textAlignment = .right
        amount.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(133)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setArrowButton() {
        let buttonImage = UIImage(named: "Icon")
        arrowButton.setImage(buttonImage, for: .normal)
        arrowButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(16)
        }
        amount.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(133)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
