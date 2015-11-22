//
//  ___VARIABLE_cocoaTouchSubclass___ViewModel
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAMEASIDENTIFIER___ViewModel.h"

___IMPORTHEADER_cocoaTouchSubclass___

@interface ___FILEBASENAMEASIDENTIFIER___ViewModel ()
@property (nonatomic, strong) ___VARIABLE_cocoaTouchSubclass___ *___VARIABLE_propertyName___;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___ViewModel
+ (instancetype)viewModelWithModel:(___VARIABLE_cocoaTouchSubclass___*)___VARIABLE_propertyName___
{
    ___FILEBASENAMEASIDENTIFIER___ViewModel *viewModel = [___FILEBASENAMEASIDENTIFIER___ViewModel new];

    viewModel.___VARIABLE_propertyName___ = ___VARIABLE_propertyName___;
    return viewModel;
}

@end