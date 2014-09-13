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

@property (weak, nonatomic) IBOutlet UITextField *focalLengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *distance;
@property (weak, nonatomic) IBOutlet UITextField *aperture;
@property (weak, nonatomic) IBOutlet UITextField *result;
@property (weak, nonatomic) IBOutlet UIButton *calculate;

@property (strong, nonatomic) NSArray* focalLengths;
@property (strong, nonatomic) NSArray* apertureData;
@property (strong, nonatomic) NSMutableArray* distanceData;

- (IBAction) calculate:(id)sender;

@end
