//
//  OPViewController.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 11.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPViewController.h"

@interface OPViewController ()

@end

@implementation OPViewController

@synthesize z;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataPicker.delegate = self;
    self.dataPicker.dataSource = self;
    self.focalLengths  = [[NSArray alloc] initWithObjects:@"24 mm", @"35 mm", @"50 mm", @"60 mm", @"70 mm", nil];
    self.apertureData = [[NSArray alloc] initWithObjects:@"1.4", @"1.8", @"2.0", @"2.8",@"4.0",@"5.6",@"6.3",@"8.0",@"16", @"18", @"20", @"22", nil];
    
    self.distanceData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++)
    {
        [self.distanceData addObject:[NSString stringWithFormat:@"%d m",i+1]];
    }
    
    self.z = [[NSNumber alloc] initWithDouble:0.03];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender
{
    NSLog(@"calculate");
    _result.text = _focalLengthTextField.text;

}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (component == 0)
    {
        return [self.focalLengths count];
    }
    else if (component == 1)
    {
        return [self.apertureData count];
    }
    else
    {
        return [self.distanceData count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.focalLengths objectAtIndex:row];
    }
    else if (component == 1)
    {
        return [self.apertureData objectAtIndex:row];
    }
    else
    {
        return [self.distanceData objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSInteger focalLengthIndex = [pickerView selectedRowInComponent:0];
    NSInteger apertureValueIndex = [pickerView selectedRowInComponent:1];
    NSInteger distanceIndex = [pickerView selectedRowInComponent:2];
    
    NSNumber* focalLength = [[NSNumber alloc] initWithDouble:[[[self.focalLengths objectAtIndex:focalLengthIndex] substringWithRange:NSMakeRange(0, 2)] doubleValue]];
    NSNumber* apertureValue = [[NSNumber alloc] initWithDouble:[[self.apertureData objectAtIndex:apertureValueIndex] doubleValue]];
    
    
    self.result.text = [[self calculateHyperFocal:focalLength withApertureValue:apertureValue] stringValue];
}

- (NSNumber*) calculateHyperFocal:(NSNumber*) focalLength withApertureValue:(NSNumber*) apertureValue
{
    NSNumber* result = [[NSNumber alloc] initWithDouble:(([focalLength doubleValue] * [focalLength doubleValue])/([apertureValue doubleValue] * [self.z doubleValue]) + [focalLength doubleValue])/1000];

    NSLog(@"Using parameter focalLength: %@", focalLength);
    NSLog(@"Using parameter aperture: %@", apertureValue);
    NSLog(@"Calculating hyperfocal distance: %@", result);
    return result;
}

@end
