//
//  NSObject+DebugDescription.m
//  ModelPoTest
//
//  Created by sunny on 2017/7/23.
//  Copyright © 2017年 sunny. All rights reserved.
//

#import "NSObject+DebugDescription.h"
#import <objc/runtime.h>
@implementation NSObject (DebugDescription)

#pragma mark - 重写description方法(调用NSLog方法打印时执行)
- (NSString *)description {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]]) {
        return self.description;
    }
    //初始化一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) { //循环并用KVC得到每个属性的值
        objc_property_t property = properties[i];
        if (property != nil) {
//               const char *oldName = property_getName(property);
//            NSString *name = [NSString stringWithFormat:@"%s",oldName];
//            NSString *name =   [NSString stringWithUTF8String:oldName];
//                 id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
//                 [dictionary setObject:value forKey:name];//装载到字典里
        }
     
    }
    //释放
    free(properties);
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}


#pragma mark - 重写debugDescription方法（控制台使用po命令时调用）
- (NSString *)debugDescription {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]]) {
        return self.debugDescription;
    }
    //初始化一个字典
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //得到当前class的所有属性
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) { //循环并用KVC得到每个属性的值
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        [dictionary setObject:value forKey:name];//装载到字典里
    }
    //释放
    free(properties);
    //return
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}
@end
