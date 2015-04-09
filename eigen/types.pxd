# Floating-point type
ctypedef fused Floating:
    float
    double

# Integral type
ctypedef fused Integral:
    unsigned char
    unsigned short
    unsigned int
    unsigned long
    char
    short
    int
    long

# General scalar type
ctypedef fused Scalar:
    unsigned char
    unsigned short
    unsigned int
    unsigned long
    char
    short
    int
    long
    float
    double
