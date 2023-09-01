/**
 * @file struct.h
 * @author Shinichi Inoue (inoue.shinichi.1800@gmail.com)
 * @brief 
 * @version 0.1
 * @date 2023-09-01
 * 
 * @copyright Copyright (c) 2023
 * 
 */
#ifndef __H_STRUCT__
#define __H_STRUCT__

struct Coordinate
{
    double latitude;
    double longitude;
};

struct Place
{
    char *name;
    struct Coordinate coordinate;
};

struct Coordinate create_coordinate(double latitude, double longitude);
struct Place create_place(char *name, double latitude, double longitude);

double distance(struct Coordinate, struct Coordinate);

char *hello_place();
char *reverse(char *str, int length);

#endif