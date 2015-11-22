//
//  ___VARIABLE_cocoaTouchSubclass___ViewModel
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___VARIABLE_cocoaTouchSubclass___ViewModel.h"

___IMPORTHEADER_cocoaTouchSubclass___

@interface ___VARIABLE_cocoaTouchSubclass___ViewModel ()
@property (nonatomic, strong) ___VARIABLE_cocoaTouchSubclass___ *___VARIABLE_modelName___;
@end

@implementation ___VARIABLE_cocoaTouchSubclass___ViewModel
+ (instancetype)viewModelWithModel:(___VARIABLE_cocoaTouchSubclass___*)___VARIABLE_modelName___
{
    ___VARIABLE_cocoaTouchSubclass___ViewModel *viewModel = [___VARIABLE_cocoaTouchSubclass___ViewModel new];

    viewModel.___VARIABLE_modelName___ = ___VARIABLE_modelName___;
    return viewModel;
}

@end