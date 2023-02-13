//
//  OnboardingContainerVC.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 12/02/2023.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    
    let closeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    
    var currentVC: UIViewController {
        didSet {
            
            guard let index = pages.firstIndex(of: currentVC) else { return }
            
            nextButton.isHidden = index == pages.count - 1 // if we on last page (hide Next button)
            backButton.isHidden = index == 0 // hide Back button if we on firs page
            doneButton.isHidden = !(index == pages.count - 1) // show if we on last page
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingVC(heroImageName: "delorean", titleText: "MoneyApp is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in 80s.")
        
        let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        
        let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at www.moneyapp.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
   
    }
    
    
    private func setup() {
        
        view.backgroundColor = .systemPurple
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        view.addSubview(backButton)
        
        
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: .normal)
        backButton.isHidden = true
        backButton.addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: .normal)
        doneButton.isHidden = true
        doneButton.addTarget(self, action: #selector(doneButtontapped), for: .touchUpInside)
        
        
        
    }
    
    private func layout() {
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -35).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15).isActive = true
        
        backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -35).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15).isActive = true
        
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -35).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15).isActive = true
    }
   
}


// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
// Actions
extension OnboardingContainerViewController {
    
    @objc func closeTapped() {
        delegate?.didFinishOnboarding()
    }
    
    @objc func nextButtonTapped() {
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
    }
    
    @objc func backButtontapped() {
        guard let getPreviosVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([getPreviosVC], direction: .forward, animated: true)
    }
    
    @objc func doneButtontapped() {
        delegate?.didFinishOnboarding()
    }
    
}
