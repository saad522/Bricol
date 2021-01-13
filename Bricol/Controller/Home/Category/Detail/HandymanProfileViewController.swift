//
//  HandymanProfileViewController.swift
//  Bricol
//
//  Created by mac on 12/29/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class HandymanProfileViewController: UICollectionViewController {
    
    //MARK: Properties
    private let cellID       = "cellID"
    private let secondCellID = "secondCellID"
    private let theirdCellID   = "theirdCellID"
    private let headerID     = "headerID"
    var user : User?
    var reviews : [Reviews] = []
    var currentUser : User?
    
    
    
    //init: ComposotionalLayout
    init(user : User?) {
        self.user = user
        let layout = UICollectionViewCompositionalLayout { (numberOfsection, _) -> NSCollectionLayoutSection? in
            
            if numberOfsection == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(530)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 8
                item.contentInsets.trailing = 8
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80)), elementKind: kind, alignment: .top)
                ]
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        fetchUserData()
        fetchReviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserData()
    }
    deinit {
        print("All looks  good ✅ ")
    }
}
//MARK: setup CollectionView
extension HandymanProfileViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else  {
            if reviews.count == 0 {
                return 1
            } else {
                return reviews.count
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HandymanProfileViewCell
            cell.user = user
            cell.didPopTapped = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            cell.didCallTapped = { [weak self] in
                guard let phone = self?.user?.phone else { return }
                let url = URL(string: "TEL://\(phone)")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            cell.didSMSTapped = { [weak self] in
                let messageController = MessageSMSViewController()
                messageController.modalPresentationStyle = .custom
                messageController.transitioningDelegate = self
                self?.present(messageController, animated: true)
            }
            cell.didLeaveReview = { [weak self] in
                if Auth.auth().currentUser?.uid != self?.user?.userId {
                    let hostingHeader = UIHostingController(rootView: LeaveReviewViewController(user: self?.user ?? dummyUser, currentUser: self?.currentUser ?? dummyUser))
                    hostingHeader.modalPresentationStyle = .fullScreen
                    hostingHeader.rootView.dismiss = { [weak self] in
                        self?.dismiss(animated: true)
                    }
                    hostingHeader.rootView.isSubmit = { [weak self] in
                        self?.dismiss(animated: true)
                    }
                    self?.present(hostingHeader, animated: true)
                }
            }
            cell.backgroundColor = .secondarySystemBackground
            return cell
        } else {
            if reviews.count != 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! ReviewsViewCell
                let review = reviews[indexPath.item]
                print("DEBUG: Bali")
                print("Rate Rview : ",reviews[indexPath.item].rate)
                cell.review = review
                return cell
            } else  {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: theirdCellID, for: indexPath) as! ReviewImageDesignCell
                return cell
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! CompositionalHeader
        header.label.text = "Reviews"
        return header
    }
   private func creatUI() {
        collectionView.backgroundColor = .secondarySystemBackground
        navigationController?.isNavigationBarHidden = true
        cellRegistration()
    
    }
    private func fetchReviews() {
        guard let handymaneID = user?.userId else { return  }
         ServiceDatabase.shared.fetchHandyManReview(handymanID: handymaneID) { [weak self] (reviews, error) in
            if let error = error {
                print("Failed To Load Review reason : ",error.localizedDescription)
                return
            }
                self?.reviews = reviews ?? []
        }
    }
   private func fetchUserData() {
        ServiceDatabase.shared.fetchUserInfo { [weak self] (userLinving, error) in
            if let error = error {
                print("Failed to Load Data reason : ",error.localizedDescription)
                return
            }
            self?.currentUser = userLinving
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    private func cellRegistration() {
        collectionView.register(HandymanProfileViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(ReviewsViewCell.self, forCellWithReuseIdentifier: secondCellID)
        collectionView.register(ReviewImageDesignCell.self, forCellWithReuseIdentifier: theirdCellID)
        collectionView.register(CompositionalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
}
struct HandymanProfileView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UINavigationController(rootViewController: HandymanProfileViewController(user: nil))
        
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
    
    typealias UIViewControllerType = UIViewController
    
}

struct HandymanProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        HandymanProfileView()
            .edgesIgnoringSafeArea(.all)
    }
}
extension HandymanProfileViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
