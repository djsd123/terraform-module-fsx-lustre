import os
import pytest
import shutil


@pytest.fixture(scope='session')
def fixtures_dir():
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), 'fixtures')


@pytest.fixture(scope='session')
def terraform_binary():
    return shutil.which('terraform')

