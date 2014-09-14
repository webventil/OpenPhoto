//
//  OPViewController.h
//  OpenPhoto
//
//  Created by Johannes Steudle on 11.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OPViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property NSNumber* z;
@property (strong, nonatomic) IBOutlet UIPickerView *focalLengthsPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *dataPicker;

@property (strong, nonatomic) IBOutlet UITextField *focalLengthTextField;
@property (strong, nonatomic) IBOutlet UITextField *nearPointTextField;
@property (strong, nonatomic) IBOutlet UITextField *farPointTextField;

@property (strong, nonatomic) NSArray* focalLengths;
@property (strong, nonatomic) NSArray* apertureData;
@property (strong, nonatomic) NSMutableArray* distanceData;

@end
