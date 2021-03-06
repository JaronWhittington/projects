
from setuptools import setup
setup(name='ecg_feature_selection',
      version='1.2.1',
      description='Filter and extract features from high noise ecg data',
      long_description='',
      author='Jaron C Whittington',
      author_email='jaronwhitty@gmail.com',
      url='https://github.com/JaronWhitty/ECG',
      license='MIT',
      setup_requires=['pytest-runner',],
      tests_require=['pytest', 'python-coveralls', 'coverage'],
      install_requires=[
          "numpy",
          "scipy"
      ],
      packages = ['ecg_feature_selection'],
      include_package_data=True,
      scripts=['ecg_feature_selection/ecg_feature_selection.py'],
              
      classifiers=[
          'Development Status :: 2 - Pre-Alpha',
          'Intended Audience :: Other Audience',
          'Natural Language :: English',
          'Operating System :: MacOS',
          'Operating System :: Microsoft :: Windows',
          'Programming Language :: Python',
          'Programming Language :: Python :: 2',
          'Programming Language :: Python :: 2.7',
          'Programming Language :: Python :: 3',
          'Programming Language :: Python :: 3.5',
          'Programming Language :: Python :: 3.6'
      ],
)
