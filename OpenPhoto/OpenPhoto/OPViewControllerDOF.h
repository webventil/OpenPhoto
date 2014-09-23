//
//  OPViewController.h
//  OpenPhoto
//
//  Created by Johannes Steudle on 11.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPViewControllerDOF : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property double z;

@property(strong, nonatomic) IBOutlet UIPickerView *focalLengthsPicker;

@property(strong, nonatomic) IBOutlet UITextField *focalLengthTextField;
@property(strong, nonatomic) IBOutlet UITextField *nearPointTextField;
@property(strong, nonatomic) IBOutlet UITextField *farPointTextField;
@property(strong, nonatomic) IBOutlet UITextField *depthOfFieldTextField;

@property(strong, nonatomic) NSMutableArray *focalLengths;
@property(strong, nonatomic) NSMutableArray *fNumberArray;
@property(strong, nonatomic) NSMutableArray *distanceData;

@end
