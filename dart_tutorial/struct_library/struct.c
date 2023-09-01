/**
 * @file struct.c
 * @author Shinichi Inoue (inoue.shinichi.1800@gmail.com)
 * @brief 
 * @version 0.1
 * @date 2023-09-01
 * 
 * @copyright Copyright (c) 2023
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "struct.h"

char *hello_place()
{
    return "Hello Japan!";
}

char *reverse(char *str, int length)
{
    // Allocate native memory in C.
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[length - i - 1] = str[i];
    }
    reversed_str[length] = '\0';
    return reversed_str;
}

void free_string(char *str)
{
    free(str);
}

struct Coordinate create_coordinate(double latitude, double longitude)
{
    struct Coordinate coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    return coordinate;
}

struct Place create_place(char *name, double latitude, double longitude)
{
    struct Place place;
    place.name = name;
    place.coordinate = create_coordinate(latitude, longitude);
    return place;
}

double distance(struct Coordinate c1, struct Coordinate c2)
{
    double xd = c2.latitude - c1.latitude;
    double yd = c2.longitude - c1.longitude;
    return sqrt(xd*xd + yd*yd);
}