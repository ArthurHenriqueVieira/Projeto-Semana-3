//
//  Roles.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Roles.h"

@implementation Roles

- (id)initWithEndereco:(NSString *)endereco
{
    self = [super init];
    if (self) {
        [self setEndereco:endereco];
    }
    return self;
}

@end
