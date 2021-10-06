//
//  PruebaCollectionViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/9/21.
//

import UIKit

class PruebaViewController: UIViewController {
    
    private var count: CGFloat = 0.0
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        ///let tableView = UITableView.init(frame: .zero)
        //let tableView = UITableView()
        //tableView.estimatedRowHeight = 44
        //tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let data = [
        ["oranges", "apple", "grapes"],
        ["one", "two", "three"],
        ["Last one"]
    ]
    
    let list = [String](repeating: "Label", count: 1) //10
    
    let imagesIdCell = "imagesIdCell"
    let photosIdCell = "albumsIdCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        delegates()
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        ///let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        header.backgroundColor = .systemGray
        ///footer.backgroundColor = .systemGreen
        
        let label = UILabel(frame: header.bounds)
        label.text = "Hello Wordl"
        label.textAlignment = .center
        header.addSubview(label)
        
        tableView.tableHeaderView = header
        ///tableView.tableFooterView = footer
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemBackground
        //tableView.separatorStyle = .none
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        tableView.reloadData()
    }
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        //tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}

extension PruebaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PruebaViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ///data.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ///return data[section].count
        if section == 1 {
            return 1 ///list.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            //cell.textLabel?.text = "\(list[indexPath.row]) \(indexPath.row)"
            count = cell.configure()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesTableViewCell.identifier, for: indexPath) as! ImagesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            let row = self.count/3
            return CGFloat(150 * (row.rounded(.up)))
        }
        return 120
    }
}




//MARK:  - PhotosTableViewCell
class PhotosTableViewCell: UITableViewCell {
    
    static  let identifier = "PhotosTableViewCell"
    
    let list = [String](repeating: "Task_", count: 7)
    
    public let label: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        return v
    }()
    
    public lazy var collectionView: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        v.delegate = self
        v.dataSource = self
        v.isScrollEnabled = false
        return v
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
        collectionView.backgroundColor = .systemPurple
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func commonInit() {
       contentView.addSubview(label)
       contentView.addSubview(collectionView)
       updateConstraints()
    }
    
    override func updateConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        super.updateConstraints()
    }
    
    public func configure() -> CGFloat {
        return CGFloat(list.count)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
        cell.label.text = "\(list[indexPath.item])\(indexPath.item+1)"
        cell.label.textAlignment = .center
        return cell
    }
}
extension PhotosTableViewCell: UICollectionViewDelegate{}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/3, height: 150)
    }
}

class CollectionCell: UICollectionViewCell {
    
    static let identifier = "CollectionCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    let padding: CGFloat = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .systemBackground
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        updateConstraints()
    }

    override func updateConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        super.updateConstraints()
    }

    public let label: UILabel = {
        let v = UILabel()
        v.textColor = .darkText
        v.minimumScaleFactor = 0.5
        v.numberOfLines = 1
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
        photoImageView.frame = CGRect(x: 1, y: 1, width: contentView.width-2, height: contentView.height)
        label.frame = CGRect(x: 10, y: contentView.height/2, width: contentView.width-20, height: contentView.height/1.5)
    }
}













//MARK:  Images
class ImagesTableViewCell: UITableViewCell {
    
    static  let identifier = "ImagesTableViewCell"
    
    private let collectionView: UICollectionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 0, height: 0)
        layout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemRed
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: IconCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImagesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCell.identifier, for: indexPath) as! IconCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 100, height: 200)
        return CGSize(width: collectionView.frame.width/3, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
   
}

class IconCell: UICollectionViewCell {
     
    static let identifier = "IconCell"
    
    let storybutton = UIButton()
    let usernameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        setupview()
        configureStoryButtom()
        configureUsernameLabel()
    }
    
    private func setupview() {
        contentView.addSubview(storybutton)
        contentView.addSubview(usernameLabel)
    }
    
    private func configureStoryButtom() {
        storybutton.backgroundColor = .systemYellow
        storybutton.frame = storybutton.bounds
    }
    
    private func configureUsernameLabel() {
        usernameLabel.text = "eddylujann"
        usernameLabel.backgroundColor = .systemYellow
        usernameLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = contentView.frame.size.width/3
        storybutton.frame = CGRect(x: center, y:10, width:50, height: 50)
        storybutton.layer.cornerRadius = storybutton.height/2
        
        let usernameLabelLabelSize = usernameLabel.sizeThatFits(frame.size)
        usernameLabel.frame = CGRect(x: 5, y: storybutton.bottom+2, width: contentView.width-10, height: usernameLabelLabelSize.height).integral
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
