//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Emil Rasmussen on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userHasUsedPoint;
@property (nonatomic, strong) CalculatorBrain *brain;
-(IBAction)enterPressed;
-(void)updateStackDisplay;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize stackDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userHasUsedPoint;
@synthesize brain = _brain;

- (CalculatorBrain *) brain{
    if(!_brain) _brain = [[CalculatorBrain alloc]init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit]; 
    }
    else{
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    [self updateStackDisplay];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = sender.currentTitle;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    [self updateStackDisplay];
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasUsedPoint = NO;
    [self updateStackDisplay];
}

- (IBAction)pointPressed:(UIButton *)sender {
    if (!userHasUsedPoint) {
    self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
        userHasUsedPoint = YES;
    }
}

-(void)updateStackDisplay{
    self.stackDisplay.text = [self.brain.programStack componentsJoinedByString:@" "];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self.brain clearProgramStack];
    [self updateStackDisplay];
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userHasUsedPoint = NO;
}

@end
