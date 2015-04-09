Eigen Python
============

A slim Python/Cython interface to the Eigen C++ template library

Eigen Python exports a number of Eigen types (namely Matrix and its derivatives)
along with some of the core functionality provided by Eigen. This package is
primarily designed to interface with external C++ libraries using Eigen in
their public API, however it can also be used for fast math.

Installation
------------

The project is best installed with `pip`. This will pull in the full
suite of Eigen headers as well:

    pip install git+https://github.com/hbristow/eigen

Usage
-----

In your Cython wrappers:

    from eigen cimport Scalar, VectorMap as Vector
    ...

    cdef Scalar sum(Scalar[:] x):
        """Sum the elements of a contiguous vector with generic scalar type"""
        cdef Vector[Scalar] xm = Vector(&x[0], x.size)
        return xm.sum()

In your setup.py:

    import numpy
    import eigen

    Extension('...',
        include_dirs = [
            numpy.get_include(),
            eigen.get_include()
        ]
        ...
    )
