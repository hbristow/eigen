# ----------------------------------------------------------------------------
# Numpy-style include_dir
# ----------------------------------------------------------------------------
def get_include():
    """Return an absolute filesystem path to the Eigen headers

    The path enables includes of the expected form:
        #include <Eigen/Dense>
        #include <Eigen/Sparse>
        ...
    """
    import os
    module  = os.path.realpath(__file__)
    package = os.path.dirname(module)
    return os.path.join(package)


# ----------------------------------------------------------------------------
# Version
# ----------------------------------------------------------------------------
def _version():
    """Return the Eigen semantic version as a tuple of X,Y,Z"""
    import os
    import re
    world = r'EIGEN_WORLD_VERSION\s+([0-9]+)'
    major = r'EIGEN_MAJOR_VERSION\s+([0-9]+)'
    minor = r'EIGEN_MINOR_VERSION\s+([0-9]+)'
    macros = os.path.join(get_include(), 'Eigen', 'src', 'Core', 'util', 'Macros.h')
    with open(macros) as f:
        source = f.read()
        world = int(re.findall(world, source)[0])
        major = int(re.findall(major, source)[0])
        minor = int(re.findall(minor, source)[0])

    # return the tuple of semantic versioning
    return world, major, minor

version = _version()
version_string = '.'.join(map(str, version))
