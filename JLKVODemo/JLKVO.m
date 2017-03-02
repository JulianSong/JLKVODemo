//
//  JLKVO.m
//  JLKVODemo
//
//  Created by Julian Song on 17/3/2.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import "JLKVO.h"
@interface JLKVO()

@end
@implementation JLKVO
- (instancetype)init
{
    if (self = [super init]) {
        _store = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@synthesize phone=_phone;

#pragma mark - class method

+ (BOOL)automaticallyNotifiesObserversOfPhone
{
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfTitle
{
    return NO;
}

/**
 cv 依赖 name,phone",title" 三个属性这三个属性任一一个变化都会触发cv的变化
 @return NSSet 相关依赖的属性
 也可用+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key  实现
 */

+ (NSSet *)keyPathsForValuesAffectingCv
{
    return [NSSet setWithObjects:@"name",@"phone",@"title", nil];
}

#pragma mark - object method

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

- (NSString *)cv
{
    return [NSString stringWithFormat:@"%@ %@ %@",_name,_phone,_title];
}

- (id)valueForUndefinedKey:(NSString *)key
{
  return [self.store valueForKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    [self.store setValue:value forKey:key];
}

@end
