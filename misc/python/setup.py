from os import path
from setuptools import setup, Distribution


here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, 'README.rst')) as f:
    long_description = f.read()


class BinaryDistribution(Distribution):
    def has_ext_modules(foo):
        return True


setup(name='kahipwrapper',
      version='0.1.7',
      description='KaHIP Python Wrapper',
      long_description=long_description,
      url='http://github.com/suriyan/KaHIP-wrapper',
      author='Suriyan Lahaprapanon, Gaurav Sood',
      author_email='suriyant@gmail.com, gsood07@gmail.com',
      license='MIT',
      packages=['kahipwrapper'],
      package_data={
          'kahipwrapper': ['_kaHIP.so'],
      },
      distclass=BinaryDistribution,
      zip_safe=False
)

