//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Emil Rasmussen on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (nonatomic, readonly) id program;

-(NSMutableArray *) programStack;
-(void) clearProgramStack;
-(void) pushOperand:(double)operand;
-(double) performOperation:(NSString *)operation;

+ (NSString *)descriptionOfProgram:(id)program;
+ (double)runProgram:(id)program;
+ (double)runProgram:(id)program
        usingVariables:(NSDictionary *)variableValues;
+ (NSSet *)variablesUsedInProgram:(id)program;

@end