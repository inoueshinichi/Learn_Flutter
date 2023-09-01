/**
 * @file primitives.c
 * @author Shinichi Inoue (inoue.shinichi.1800@gmail.com)
 * @brief 
 * @version 0.1
 * @date 2023-09-01
 * 
 * @copyright Copyright (c) 2023
 * 
 */
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include "primitives.h"


int sum(int a, int b)
{
    return a + b;
}

int sub(int *a, int b)
{
    return *a - b;
}

int *mul(int a, int b)
{
    int *mult = (int *)malloc(sizeof(int));
    *mult = a * b;
    return mult;
}

void free_ptr(int *ptr) {
    free(ptr);
}