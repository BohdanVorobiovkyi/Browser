//
//  ViewController.swift
//  Browser
//
//  Created by usr01 on 08.04.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import WebBrowser
import WebKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var browserContainer: UIView!
    
    var webBrowserViewController : WebBrowserViewController! = WebBrowserViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupSearchBar()
        setupWebBrowser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        webBrowserViewController.loadURLString("https://www.apple.com/")
    }
    
    private func setupSearchBar() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        searchBar.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.blue ], for: .normal)
        searchBar.returnKeyType = .search
        searchBar.tintColor = .lightGray
        searchBar.becomeFirstResponder()
    }
    
    private func installViewController(_ viewController: UIViewController?, inContainerView containerView: UIView) {
        if let viewController = viewController {
            addChild(viewController)
            viewController.view.frame = containerView.bounds
            containerView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    private func setupWebBrowser() {
        webBrowserViewController.delegate = self
        webBrowserViewController.onOpenExternalAppHandler = { [weak self] _ in
            guard let `self` = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        webBrowserViewController.language = .english
        webBrowserViewController.tintColor = .black
        webBrowserViewController.barTintColor = .white
        webBrowserViewController.isToolbarHidden = false
        webBrowserViewController.isShowActionBarButton = true
        webBrowserViewController.toolbarItemSpace = 50
        webBrowserViewController.isShowURLInNavigationBarWhenLoading = false
        webBrowserViewController.isShowPageTitleInNavigationBar = false

        for view in webBrowserViewController.view.subviews {
            if view.isKind(of: WKWebView.self) {
                let v = view as? WKWebView
                v?.scrollView.keyboardDismissMode = .onDrag
            }
        }
        webBrowserViewController.loadURLString("https://www.google.com/")
        let nav = UINavigationController(rootViewController: webBrowserViewController)
        nav.navigationBar.isHidden = true
        installViewController(nav, inContainerView: browserContainer)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let userText = searchBar.text, userText != "" {
            webBrowserViewController.loadURLString(userText)
            searchBar.resignFirstResponder()
        }
    }
}

extension ViewController: WebBrowserDelegate {
    func webBrowser(_ webBrowser: WebBrowserViewController, didStartLoad url: URL?) {
        print("Start loading...")
    }
    
    func webBrowser(_ webBrowser: WebBrowserViewController, didFinishLoad url: URL?) {
        print("Finish loading!")
    }
    
    func webBrowser(_ webBrowser: WebBrowserViewController, didFailLoad url: URL?, withError error: Error) {
        print("Failed to load! \n error: \(error)")
    }
    
    func webBrowserWillDismiss(_ webBrowser: WebBrowserViewController) {
        
    }
    
    func webBrowserDidDismiss(_ webBrowser: WebBrowserViewController) {
        
    }
}


