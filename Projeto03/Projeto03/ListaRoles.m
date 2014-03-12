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

-(Roles *) criarRoleDo:(Usuario *)dono noEndereco:(Endereco *)endereco
{
    Roles *r = [[Roles alloc] initWithDono:dono andEndereco:endereco];
    
    [tudo addObject: r];
    
    return r;
}

-(void)removeEndereco: (Roles *)r
{
    [tudo removeObjectIdenticalTo:r];
}

-(NSArray *)rolesDistando:(double)metros doLocal:(CLLocationCoordinate2D)origem
{
    NSMutableArray *roles = [[NSMutableArray alloc] init];
    
    for (Roles *role in [ListaRoles lista])
    {
        CLLocation *localA = [[CLLocation alloc] initWithLatitude:origem.latitude longitude:origem.longitude];
        CLLocation *localB = [[CLLocation alloc] initWithLatitude:[role.endereco _coord].latitude longitude:[role.endereco _coord].longitude];
        CLLocationDistance distancia = [localA distanceFromLocation:localB];
        
        if (distancia <= metros)
            [roles addObject:role];
    }
    
    return roles;
}

@end
