"""Plugwise module."""

import importlib.metadata

__version__ = importlib.metadata.version(__package__ or __name__)

from plugwise.smile import Smile
from plugwise.stick import Stick
