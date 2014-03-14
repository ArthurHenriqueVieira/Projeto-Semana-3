//
//  Endereco.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "Endereco.h"

@implementation Endereco

- (id)init
{
    self = [super init];
    if (self)
    {
        [self set_inicializado:NO];
    }
    return self;
}

- (id)initWithNome:(NSString *)nome andCoordinate:(CLLocationCoordinate2D)coord
{
    self = [super init];
    if (self)
    {
        [self set_nome:nome];
        [self set_coord:coord];
        [self set_inicializado:YES];
    }
    return self;
}

@end
