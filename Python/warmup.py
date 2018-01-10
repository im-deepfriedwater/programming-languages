import re
from random import sample
from math import pi
from itertools import zip_longest, chain
from ast import literal_eval
from Crypto.Cipher import AES
import requests


def change(amount):
  if amount < 0:
    raise ValueError('amount cannot be negative')
  answer = []
  remaining = amount
  for coin in (25, 10, 5, 1):
    quotient, remainder = divmod(remaining, coin)
    answer.append(quotient)
    remaining = remainder
  return tuple(answer)

def strip_quotes(string):
  return re.sub('\'|\"', '', string)

def scramble(string):
  return ''.join(sample(string, len(string)))

def say(string=''):
  words = []
  def say_more(string=''):
    if string:
      words.append(string)
    return say_more if string else ' '.join(words)
  return say_more(string)

def triples(limit):
  return sorted(((a, b, c) for c in range(1, limit + 1) for b in range(1, c)
                 for a in range(1, b) if a ** 2 + b ** 2 == c ** 2))

def powers(base, limit):
  base_to_the_power = 1

  while base_to_the_power <= limit:
    yield base_to_the_power
    base_to_the_power *= base

def interleave(list1, *rest):
  zipped = zip_longest(list1, rest)
  return [element for element in chain(*zipped) if element != None]

class Cylinder:
  def __init__(self, radius=1, height=1):
    self.radius = radius
    self.height = height

  @property
  def volume(self):
    return pi * self.radius ** 2 * self.height

  @property
  def surface_area(self):
    return 2 * pi * (self.radius ** 2 + self.radius * self.height)

  def widen(self, factor):
    self.radius *= factor

  def stretch(self, factor):
    self.height *= factor

def make_crypto_functions(key, initialization_vector):
  byte_key = bytes(key, encoding='UTF-8')
  byte_IV = bytes(initialization_vector, encoding='UTF-8')

  def encrypt(byte_string):
    cipher = AES.new(byte_key, AES.MODE_CBC, byte_IV)
    return cipher.encrypt(byte_string)

  def decrypt(byte_string):
    cipher = AES.new(byte_key, AES.MODE_CBC, byte_IV)
    return cipher.decrypt(byte_string)

  return (encrypt, decrypt)

def random_name(gender=None, region=None):
  query_parameters = dict(gender=gender, region=region, amount=1)
  request = requests.get('https://uinames.com/api/', query_parameters)
  response_dict = literal_eval(request.text)
  if 'error' in response_dict.keys():
    raise ValueError(request.text)
  return response_dict['surname'] + ', ' + response_dict['name']
