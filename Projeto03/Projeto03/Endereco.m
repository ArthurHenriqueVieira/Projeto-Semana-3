//
//  Endereco.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Endereco.h"

@implementation Endereco

- (id)initWithNome:(NSString *)nome andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self)
    {
        [self set_nome:nome];
        [self set_coord:coord];
    }
    return self;
}

@end
