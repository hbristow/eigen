Eigen Python
============

A slim Python/Cython to the Eigen C++ template library

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

    from eigen cimport Map, Scalar
    ...

    cdef Scalar sum(Scalar[:] x):
        """Sum the elements of a contiguous array"""
        cdef Map[Scalar] xm = Map(&x[0], x.size)
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
