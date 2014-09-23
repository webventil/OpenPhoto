//
//  OPViewControllerFOV.h
//  OpenPhoto
//
//  Created by Johannes Steudle on 23.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPViewControllerFOV : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic) IBOutlet UITextField *fieldHorizontalAngle;
@property(strong, nonatomic) IBOutlet UITextField *fieldVerticalAngle;
@property(strong, nonatomic) IBOutlet UITextField *fieldDiagonalAngle;
@property(strong, nonatomic) IBOutlet UIPickerView *focalLengthPicker;

@property(strong, nonatomic) NSArray *focalLengths;

@end
