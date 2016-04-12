//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//


import UIKit

// MARK: - ViewController
public class ___FILEBASENAMEASIDENTIFIER___ViewController: UIViewController, ___FILEBASENAMEASIDENTIFIER___Protocol {
    // MARK: Business
    var business: ___FILEBASENAMEASIDENTIFIER___Business?
    // MARK: Other Variable

    // MARK: Object Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    deinit {
    }
}

// MARK: - SupportBusiness
extension ___FILEBASENAMEASIDENTIFIER___ViewController: SupportBusiness {
    public func setBusiness(business: Business?) {
        self.business = business as? ___FILEBASENAMEASIDENTIFIER___Business
    }
}

// MARK: - Controller Cycle
extension ___FILEBASENAMEASIDENTIFIER___ViewController {
    public override func viewDidLoad() {
        doSomethingOnLoad()
    }
    public override func viewDidAppear(animated: Bool) {
    }
    public override func viewWillAppear(animated: Bool) {
    }
    public override func viewWillDisappear(animated: Bool) {
    }
    public override func viewDidDisappear(animated: Bool) {
    }
}
// MARK: - Task On Load
extension ___FILEBASENAMEASIDENTIFIER___ViewController{
    // MARK: Setup

    // MARK: Load
    func doSomethingOnLoad()
    {
        // business.doSomething()
    }
}