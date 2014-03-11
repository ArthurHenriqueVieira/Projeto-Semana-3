//
//  ListaRoles.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "ListaRoles.h"
#import "Endereco.h"

@implementation ListaRoles

+(ListaRoles *) lista
{
    static ListaRoles *lista = nil;
    if (!lista)
    {
        lista = [[super allocWithZone:nil] init];
    }
    return lista;
}

+(id) allocWithZone: (struct _NSZone *)zone
{
    return [self lista];
}

- (id)init
{
    self = [super init];
    if (self) {
        tudo = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray *)todosItens
{
    return tudo;
}

-(Roles *) criarRole:(Endereco *)endereco
{
    Roles *r = [[Roles alloc] initWithEndereco:endereco];
    
    [tudo addObject: r];
    
    return r;
}

-(void)removeEndereco: (Roles *)r
{
    [tudo removeObjectIdenticalTo:r];
}

@end
