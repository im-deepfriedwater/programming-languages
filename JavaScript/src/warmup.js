function change(amount) {
  if (amount < 0) {
    throw new RangeError('Input must be a positive value.');
  }
  let currentValue = amount;
  const denominations = [25, 10, 5, 1];
  const answer = [];
  denominations.forEach((coin) => {
    answer.push(Math.floor(currentValue / coin));
    currentValue %= coin;
  });

  return answer;
}

function stripQuotes(str) {
  return (str.replace(/"|'/g, ''));
}

function scramble(str) {
  let scrambledString = '';
  const word = str.split('');
  while (word.length) {
    const randomIndex = Math.floor(Math.random() * word.length);
    scrambledString += word.splice(randomIndex, 1);
  }
  return scrambledString;
}

function powers(base, limit, callback) {
  let power = 0;
  let currentValue = base ** power;
  while (currentValue <= limit) {
    callback(currentValue);
    power += 1;
    currentValue = base ** power;
  }
}

function powersGenerator(base, limit) {
  let power = 0;
  return {
    next: () => {
      const currentValue = base ** power;
      const overLimit = currentValue > limit;
      power += 1;
      return {
        value: overLimit ? undefined : currentValue,
        done: overLimit,
      };
    },
  };
}

function say(input) {
  let words = '';

  const chain = (str) => {
    if (str) {
      words += str + " ";
    }

    return str ? chain : words.trim();
  };

  return chain(input);
}

function interleave(array, ...rest) {
  const shorter = array.length > rest.length ? rest : array;
  const longer = array.length > rest.length ? array : rest;
  const answer = [];

  for (let i = 0; i < shorter.length; i += 1) {
    answer.push(array[i]);
    answer.push(rest[i]);
  }

  return answer.concat(longer.slice(shorter.length, longer.length));
}

function cylinder(data) {
  let { height = 1, radius = 1 } = data;

  function surfaceArea() {
    return (Math.PI * 2 * radius * height) + (Math.PI * 2 * (radius ** 2));
  }

  function volume() {
    return Math.PI * (radius ** 2) * height;
  }

  function widen(widenFactor) {
    radius *= widenFactor;
  }

  function stretch(stretchFactor) {
    height *= stretchFactor;
  }

  function toString() {
    return `Cylinder with radius ${radius} and height ${height}`;
  }

  return Object.freeze({
    get height() {
      return height;
    },
    get radius() {
      return radius;
    },
    surfaceArea,
    volume,
    widen,
    stretch,
    toString,
  });
}

function makeCryptoFunctions(key, algorithm) {
  const crypto = require('crypto');
  return [
    function encrypt(str) {
      const cipher = crypto.createCipher(algorithm, key);
      const crypted = cipher.update(str, 'utf8', 'hex');
      return crypted + cipher.final('hex');
    },
    function decrypt(str) {
      const decipher = crypto.createDecipher(algorithm, key);
      const decrypted = decipher.update(str, 'hex', 'utf8');
      return decrypted + decipher.final('utf8');
    },
  ];
}

function randomName(data) {
  const request = require('request-promise');
  const {gender, region} = data;

  const formData = {
    gender,
    region,
    amount: 1,
  };

  let answer = '';
  const options = {
    url: 'https://uinames.com/api/',
    qs: formData,
    json: true,
    callback: (error, response, apiData) => {
      answer = (`${apiData.surname}, ${apiData.name}`);
    },
  };

  return request(options).then(() => answer);
}


module.exports = {
  change,
  stripQuotes,
  scramble,
  powers,
  powersGenerator,
  say,
  interleave,
  cylinder,
  makeCryptoFunctions,
  randomName,
};
