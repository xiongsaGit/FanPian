//
//  SMTCollectionTypeRequest.h
//  FanPian
//
//  Created by sa.xiong on 16/1/23.
//  Copyright © 2016年 sa.xiong. All rights reserved.
//

#import "SMTBaseRequest.h"


typedef NS_ENUM(NSInteger,CollectionOrSalonType) {
    CollectionOrSalonTypeCollection,
    CollectionOrSalonTypeSalon,

};
@interface SMTCollectionTypeRequest : SMTBaseRequest

- (id)initWithType:(CollectionOrSalonType)type page:(NSNumber *)page ctid:(NSString *)ctid;

@end
