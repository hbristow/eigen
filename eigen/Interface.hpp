/** Interface.hpp
  *
  * This interface defines a transparent mapping for Dense Eigen types
  * that exposes only the Scalar template parameter so that template
  * specialization can be performed in Cython.
  *
  * This requires a C++11 compliant compiler.
  */
#ifndef EIGEN_PYTHON_HPP
#define EIGEN_PYTHON_HPP
#include <Eigen/Dense>


template <typename BaseType>
class Map : public Eigen::Map<BaseType>
{
    public:
        typedef Eigen::Map<BaseType> Base;
        typedef typename Base::Scalar Scalar;

        /** default constructor
          *
          * This sets the pointer to NULL, so must NOT be accessed before initialized!
          * For auto-generated Cython code, this is not an issue
          */
        Map() : Base(NULL,
            BaseType::RowsAtCompileTime == Eigen::Dynamic ? 0 : BaseType::RowsAtCompileTime,
            BaseType::ColsAtCompileTime == Eigen::Dynamic ? 0 : BaseType::ColsAtCompileTime) {
        }

        /** Vector constructor
          *
          * \param data pointer to the data array
          * \param size the number of elements in the array
          */
        Map(Scalar * data, Eigen::Index size) : Base(data,
            BaseType::RowsAtCompileTime == Eigen::Dynamic ? size : BaseType::RowsAtCompileTime,
            BaseType::ColsAtCompileTime == Eigen::Dynamic ? 1 : BaseType::ColsAtCompileTime) {
        }

        /** Matrix constructor
          *
          * \param data pointer to the data array
          * \param rows the number of rows (M) in the matrix
          * \param cols the number of cols (N) in the matrix
          */
        Map(Scalar * data, Eigen::Index rows, Eigen::Index cols) : Base(data,
            BaseType::RowsAtCompileTime == Eigen::Dynamic ? rows : BaseType::RowsAtCompileTime,
            BaseType::ColsAtCompileTime == Eigen::Dynamic ? cols : BaseType::ColsAtCompileTime) {
        }

        /** Assignment (initialization) operator
          *
          * \param other the initialized Map to replace this Map with
          */
        Map<BaseType>& operator=(const Map<BaseType>& other) {
            new (this) Base(other.m_data,
                BaseType::RowsAtCompileTime == Eigen::Dynamic ? other.m_rows.value() : BaseType::RowsAtCompileTime,
                BaseType::ColsAtCompileTime == Eigen::Dynamic ? other.m_cols.value() : BaseType::ColsAtCompileTime);
            return *this;
        }

        /** Copy constructor
          * \param other the other Eigen object
          */
        template <typename OtherDerived>
        Map<BaseType>(const Eigen::MatrixBase<OtherDerived>& other) : Base(other) {}

        /** General assignment operator
          * \param other the other Eigen object
          */
        template <typename OtherDerived>
        Map<BaseType>& operator=(const Eigen::MatrixBase<OtherDerived>& other) {
            this->Base::operator=(other);
            return *this;
        }
};

template <typename Scalar>
using Matrix = Eigen::Matrix<Scalar, Eigen::Dynamic, Eigen::Dynamic>;

template <typename Scalar>
using MatrixMap = Map<Matrix<Scalar> >;

template <typename Scalar>
using Vector = Eigen::Matrix<Scalar, Eigen::Dynamic, 1>;

template <typename Scalar>
using VectorMap = Map<Vector<Scalar> >;

template <typename Scalar>
using Array = Eigen::Array<Scalar, Eigen::Dynamic, Eigen::Dynamic>;


#endif // EIGEN_PYTHON_HPP
