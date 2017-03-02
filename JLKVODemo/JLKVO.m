//
//  JLKVO.m
//  JLKVODemo
//
//  Created by Julian Song on 17/3/2.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "JLKVO.h"

@implementation JLKVO
@synthesize phone=_phone;
+ (BOOL)automaticallyNotifiesObserversOfPhone
{
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfTitle
{
    return NO;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (void)setPhone:(NSString *)phone
{
    [self willChangeValueForKey:@"phone"];
    _phone = phone;
    [self didChangeValueForKey:@"phone"];
}

- (void)setTitle:(NSString *)title
{
    [self willChangeValueForKey:@"title"];
    _title = title;
    [self didChangeValueForKey:@"title"];
}

@end
