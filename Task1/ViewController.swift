import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var arrowButton = UIButton()
    private var repaymentLabel = UILabel()
    private var cardView = UIView()
    private var imageView = UIImageView()
    private var monthLabel = UILabel()
    private var durationLabel = UILabel()
    private var tableView = UITableView()
    private var line = LineView()
    private var dashedLine = LineView()
    private var sliceBillButton = UIButton()
    private var payNowButton = UIButton()
    private var viewData: DataFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureArrowButton()
        configureRepaymentLabel()
        configureCardView()
        configureImageView()
        configureMonthLabel()
        configureDurationLabel()
        configureTableView()
        configureLineView()
        configureDashedLineView()
        configureSliceBillButton()
        configurePayNowButton()
        fetchData() { [weak self] DataFile in
            self?.viewData = DataFile
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.setData()
            }
        }
    }
    
    private func addSubviews () {
        view.addSubview(arrowButton)
        view.addSubview(repaymentLabel)
        view.addSubview(cardView)
        cardView.addSubview(imageView)
        imageView.addSubview(monthLabel)
        imageView.addSubview(durationLabel)
        cardView.addSubview(tableView)
        cardView.addSubview(line)
        cardView.addSubview(dashedLine)
        cardView.addSubview(sliceBillButton)
        view.addSubview(payNowButton)
    }
    
    private func configureArrowButton () {
        let buttonImage = UIImage(named: "Left Arrow")
        arrowButton.setImage(buttonImage, for: .normal)
        arrowButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(48)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    private func configureRepaymentLabel () {
        repaymentLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        repaymentLabel.snp.makeConstraints { make in
            make.width.equalTo(276)
            make.height.equalTo(48)
            make.leading.equalToSuperview().offset(60)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    private func configureCardView () {
        cardView.snp.makeConstraints { make in
            make.width.equalTo(325)
            make.height.equalTo(337)
            make.top.equalToSuperview().offset(156)
            make.centerX.equalToSuperview()
        }
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 0.89, green: 0.914, blue: 0.937, alpha: 1).cgColor
        cardView.backgroundColor = .white
        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 32)
        cardView.layer.shadowRadius = 50
        cardView.layer.shadowOpacity = 1
        cardView.layer.cornerRadius = 16
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func configureImageView () {
        imageView.image = UIImage(named: "Image")
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(90)
        }
    }
    
    private func configureMonthLabel () {
        monthLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        monthLabel.textColor = .white
        monthLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(28)
        }
    }
    
    private func configureDurationLabel () {
        durationLabel.font = UIFont.systemFont(ofSize: 10)
        durationLabel.textColor = .white
        durationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(12)
            make.leading.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCell()
        if indexPath.section == viewData?.list.count {
            cell.category.text = viewData?.summaryListItem.leftLabel
            cell.amount.text = viewData?.summaryListItem.rightLabel
            cell.amount.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.category.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
        else {
            cell.category.text = viewData?.list[indexPath.section].leftLabel
            cell.amount.text = viewData?.list[indexPath.section].rightLabel
            cell.setArrowButton()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewData?.list.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (viewData?.list.count ?? 0) - 1 {
            return 35
        }
        else if section == viewData?.list.count {
            return 0
        }
        else {
            return 16
        }
    }
    
    private func configureTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 20
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(265)
            make.top.equalToSuperview().offset(109)
            make.height.equalTo(145)
        }
    }
    
    private func configureLineView () {
        line.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(217)
            make.width.equalTo(265)
            make.height.equalTo(1)
        }
    }
    
    private func configureDashedLineView () {
        dashedLine.backgroundColor = .white
        dashedLine.pattern = [5.0, 3.0]
        dashedLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(273)
            make.width.equalTo(265)
            make.height.equalTo(1)
        }
    }
    
    private func configureSliceBillButton () {
        sliceBillButton.setTitle("Slice Bill", for: .normal)
        let buttonColor = UIColor(red: 0.384, green: 0.302, blue: 0.761, alpha: 1)
        sliceBillButton.backgroundColor = .white
        sliceBillButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        sliceBillButton.setTitleColor(buttonColor, for: .normal)
        sliceBillButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(281)
            make.width.equalTo(91)
            make.height.equalTo(48)
        }
    }
    
    private func configurePayNowButton () {
        payNowButton.backgroundColor = UIColor(red: 0.384, green: 0.302, blue: 0.761, alpha: 1)
        payNowButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        payNowButton.layer.cornerRadius = 24
        payNowButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(325)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    }
    
    private struct DataFile: Codable{
        let screenTitle: String
        let banner: Mybanner
        let list: [Mylist]
        let summaryListItem: MysummaryListItem
        let cta: Mycta
    }
    
    private struct Mybanner: Codable{
        let title: String
        let subtext: String
    }
    
    private struct Mylist: Codable{
        let leftLabel: String
        let rightLabel: String
    }
    
    private struct MysummaryListItem: Codable{
        let leftLabel: String
        let rightLabel: String
    }
    
    private struct Mycta: Codable{
        let text: String
    }
    
    private func fetchData (completion: @escaping (DataFile) -> ()) {
        let urlString = "https://mocki.io/v1/8d9eb626-ff85-4550-8f4e-51a972f2b179"
        let url = URL(string: urlString)
        guard url != nil else {
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            var res: DataFile?
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let DataFile = try decoder.decode(DataFile.self, from: data!)
                    res = DataFile
                }
                catch {
                    print("Error")
                }
                completion(res!)
            }
        }
        dataTask.resume()
    }
    
    private func setData () {
        durationLabel.text = viewData?.banner.subtext
        monthLabel.text = viewData?.banner.title
        repaymentLabel.text = viewData?.screenTitle
        payNowButton.setTitle(viewData?.cta.text, for: .normal)
    }
}
