from setuptools import setup, Distribution


class BinaryDistribution(Distribution):
    def has_ext_modules(foo):
        return True


setup(name='kahipwrapper',
      version='0.1.1',
      description='KaHIP Python Wrapper',
      url='http://github.com/suriyan/KaHIP-wrapper',
      author='Suriyan Lahaprapanon',
      author_email='suriyant@gmail.com',
      license='MIT',
      packages=['kahipwrapper'],
      package_data={
          'kahipwrapper': ['_kaHIP.so'],
      },
      distclass=BinaryDistribution,
      zip_safe=False
)

