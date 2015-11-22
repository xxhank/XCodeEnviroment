//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAMEASIDENTIFIER___ViewModel.h"
#import "___FILEBASENAMEASIDENTIFIER___.h"

@interface ___FILEBASENAMEASIDENTIFIER___ViewModel ()
@property (nonatomic, strong) ___FILEBASENAMEASIDENTIFIER___ *page;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewModel
+ (instancetype)viewModelWithModel:(___FILEBASENAMEASIDENTIFIER___*)page
{
    ___FILEBASENAMEASIDENTIFIER___ViewModel *viewModel = [___FILEBASENAMEASIDENTIFIER___ViewModel new];

    viewModel.page = page;
    return viewModel;
}

@end
