//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

let ___FILEBASENAMEASIDENTIFIER___InteractorErrorDomain = "___FILEBASENAMEASIDENTIFIER___Interactor"
enum ___FILEBASENAMEASIDENTIFIER___InteractorError: ErrorType {
    case General
}


protocol ___FILEBASENAMEASIDENTIFIER___InteractorOutput
{
    func presentSomething(response: Response<___FILEBASENAMEASIDENTIFIER___Response>)
}

class ___FILEBASENAMEASIDENTIFIER___Interactor: ___FILEBASENAMEASIDENTIFIER___InteractorInput
{
    var output: ___FILEBASENAMEASIDENTIFIER___InteractorOutput!
    var worker: ___FILEBASENAMEASIDENTIFIER___Worker!
    
    // MARK: - Business logic
    func doSomething(request: ___FILEBASENAMEASIDENTIFIER___Request)
    {
        // NOTE: Create some Worker to do the work
        
        // worker = ___FILEBASENAMEASIDENTIFIER___Worker()
        // worker.doSomeWork()
        
        // NOTE: Pass the result to the Presenter
        
        //let response = ___FILEBASENAMEASIDENTIFIER___Response()
        // output.presentSomething(response)
        PMIAPI.fetchJSON("<#action#>", parameters: [:])
            .success { (responseData) -> Void in
                if let responseData = responseData as? [String: AnyObject] {
                    let response = <#Response#>(detail: responseData)
                    self.output.<#present#>(Response.Result(response))
                } else {
                    let error = NSError(domain: ___FILEBASENAMEASIDENTIFIER___InteractorErrorDomain,
                        code: ___FILEBASENAMEASIDENTIFIER___InteractorError.General)

                    self.output.<#present#>(Response.Error(error))
                }
            }.failure { (error, isCancelled) -> Void in
                if !isCancelled {
                    self.output.<#present#>(Response.Error(error!))
                }
            }
    }
}