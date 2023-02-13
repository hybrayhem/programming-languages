#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct fract { // fraction struct
    int n;     // numerator
    int d;     // denominator
} fract;

/*
///////////////////////// Fraction functions /////////////////////////
*/

// Fraction to double
double fr2d(fract a) {
    return (double)a.n / a.d;
}

// Double to fraction
fract d2fr(double a) {
    fract f;
    f.n = a * 1000000;
    f.d = 1000000;
    return f;
}

// Parse fraction from string "nfd" as fract
fract parse_fract(char *str) {
    fract f;
    f.n = atoi(str);
    f.d = atoi(strchr(str, '/') + 1);
    return f;
}

// Parce fraction string as double
double parse_fractd(char *str) {
    fract f = parse_fract(str);
    return (double)f.n / f.d;
}

// Fraction sum
fract fsum(fract a, fract b) {
    fract c;
    c.n = a.n * b.d + b.n * a.d;
    c.d = a.d * b.d;
    return c;
}

// Fraction substraction
fract fsub(fract a, fract b) {
    fract c;
    c.n = a.n * b.d - b.n * a.d;
    c.d = a.d * b.d;
    return c;
}

// Fraction multiplication
fract fmul(fract a, fract b) {
    fract c;
    c.n = a.n * b.n;
    c.d = a.d * b.d;
    return c;
}

// Fraction division
fract fdiv(fract a, fract b) {
    fract c;
    c.n = a.n * b.d;
    c.d = a.d * b.n;
    return c;
}

// Fraction operations with double return
double fsumd(fract a, fract b) {
    fract c = fsum(a, b);
    return (double)c.n / c.d;
}
double fsubd(fract a, fract b) {
    fract c = fsub(a, b);
    return (double)c.n / c.d;
}
double fmuld(fract a, fract b) {
    fract c = fmul(a, b);
    return (double)c.n / c.d;
}
double fdivd(fract a, fract b) {
    fract c = fdiv(a, b);
    return (double)c.n / c.d;
}

/*
///////////////////////// Parser functions /////////////////////////
*/

// Get value of identifier using symbol table
fract getIDValue(char *name) {}
double getIDValued(char *name) {}