"""Eigen Interface

This interface exposes Dense Eigen types through the Interface.hpp
shim. The inheritance hierarchy defined is not strictly correct,
but since Cython does not aggressively check its correctness, it
makes Cython inheritance much simpler.

There is some duplication, especially of static methods, because
Cython does not currently support operator=() overloading
"""

# ----------------------------------------------------------------------------
# Eigen Matrix
# ----------------------------------------------------------------------------
cdef extern from 'Interface.hpp' nogil:

    # Integral types
    ctypedef long Index

    # Eigen::Array
    # Elementwise operations on matrices
    cdef cppclass Array[Scalar]:
        Matrix matrix()
        Array& operator+(Scalar v)
        Array& add 'operator+='(Scalar v)

    # Eigen::Matrix<Scalar, Dynamic, Dynamic>
    # Base storage type for all matrices, vectors and maps
    cdef cppclass Matrix[Scalar]:
        # constructors
        Matrix()
        Matrix(Index rows, Index cols)
        @staticmethod
        Matrix Zero(Index rows, Index cols)
        @staticmethod
        Matrix Constant(Index rows, Index cols, Scalar value)
        @staticmethod
        Matrix Identity(Index rows, Index cols)
        @staticmethod
        Matrix Random(Index rows, Index cols)
        void fill(Scalar value)
        void setRandom()
        void setIdentity()
        # accessors
        Index rows()
        Index cols()
        Vector col(Index col)
        Vector row(Index row)
        Scalar& at 'operator()'(Index m, Index n)
        Matrix& copy 'operator='(Matrix& other)
        Matrix block(Index m, Index n, Index rows, Index cols)
        # operators and arithmetic
        Scalar sum()
        Scalar prod()
        Scalar mean()
        Scalar min 'minCoeff'()
        Scalar max 'maxCoeff'()
        Scalar trace()
        Array array()

    # Eigen::Matrix<Scalar, Dynamic, 1>
    # Column vector specialization of Matrix
    cdef cppclass Vector[Scalar](Matrix):
        Vector()
        Vector(Index size)
        Scalar& at 'operator()'(Index m)

    # Eigen::Map<Matrix>
    # Matrix shape with data mapped from a foreign array
    cdef cppclass MatrixMap[Scalar](Matrix):
        MatrixMap()
        MatrixMap(Scalar * data, Index rows, Index cols)

    # Eigen::Map<Vector>
    # Vector shape with data mapped from a foreign array
    cdef cppclass VectorMap[Scalar](Vector):
        VectorMap()
        VectorMap(Scalar * data, Index size)


# ----------------------------------------------------------------------------
# Common Types
# We declare them here so they are correctly recognized by Cython
# ----------------------------------------------------------------------------
ctypedef Array[double] ArrayXd
ctypedef Array[float] ArrayXf
ctypedef Array[short] ArrayXs
ctypedef Array[int] ArrayXi

ctypedef Matrix[double] MatrixXd
ctypedef Matrix[float] MatrixXf
ctypedef Matrix[short] MatrixXs
ctypedef Matrix[int] MatrixXi

ctypedef MatrixMap[double] MatrixMapXd
ctypedef MatrixMap[float] MatrixMapXf
ctypedef MatrixMap[short] MatrixMapXs
ctypedef MatrixMap[int] MatrixMapXi

ctypedef Vector[double] VectorXd
ctypedef Vector[float] VectorXf
ctypedef Vector[short] VectorXs
ctypedef Vector[int] VectorXi

ctypedef VectorMap[double] VectorMapXd
ctypedef VectorMap[float] VectorMapXf
ctypedef VectorMap[short] VectorMapXs
ctypedef VectorMap[int] VectorMapXi
