//
//  JLKVO.h
//  JLKVODemo
//
//  Created by Julian Song on 17/3/2.
//  Copyright © 2017年 Julian Song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLKVO : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSMutableArray *role;
@property(nonatomic,strong)NSMutableDictionary *store;
@property(nonatomic,strong,readonly)NSString *cv;
@property(nonatomic,strong)NSMutableArray<NSNumber *> *access;

- (void)updateInnerValue:(NSString *)innerVal;
@end
