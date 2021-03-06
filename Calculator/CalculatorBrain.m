//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Emil Rasmussen on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

-(void) clearProgramStack{
    [self.programStack removeAllObjects];
}

-(NSMutableArray *) programStack{
    if(!_programStack){
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (id)program{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program{
    return @"Implement this in Homework #2";
}

-(void) pushOperand:(double)operand{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

-(double) performOperation:(NSString *)operation{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    double result;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]){
        result = [topOfStack doubleValue];
    }
    
    else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;

        if([operation isEqualToString:@"+"]){
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        }
        else if([operation isEqualToString:@"*"]){
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        }
        else if([operation isEqualToString:@"-"]){
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        }
        else if([operation isEqualToString:@"/"]){
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        }
        else if([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOffProgramStack:stack]);
        }
        else if([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOffProgramStack:stack]);
        }
        else if([operation isEqualToString:@"sqrt"]){
            result = sqrt([self popOperandOffProgramStack:stack]);
        }
        else if([operation isEqualToString:@"π"]){
            result = M_PI;
        }
    }
    return result;
}

+ (double)runProgram:(id)program{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

+ (double) runProgram:(id)program
       usingVariables:(NSDictionary *)variableValues;{
    double result;
    
    return result;
}

+ (NSSet *)variablesUsedInProgram:(id)program{
    NSSet *result;
    
    return result;
}

@end
