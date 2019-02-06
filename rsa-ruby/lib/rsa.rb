# Needed as it includes "Bignum"
require 'openssl'
require 'prime'

class RSA
  ALPHABET = %w(. A B C D E F G H I J K L M N O P Q R S T U V W X Y Z).freeze

  # Implemented following this algorithm : https://en.wikipedia.org/wiki/Modular_exponentiation#Right-to-left_binary_method
  # Which is O(log(n))
  def self.exponentiation_modulaire(x, k, n)
    result = 1
    base   = x
    while k > 0
      result = (result * base) % n if (k & 1) == 1
      k    = k >> 1
      base = (base**2) % n
    end
    result
  end

  # Implemented following : https://fr.wikipedia.org/wiki/Algorithme_d%27Euclide_%C3%A9tendu#L'algorithme
  def self.euclide_etendu(a, b)
    r = a
    u = 1
    v = 0
    r2 = b
    u2 = 0
    v2 = 1
    q = 0

    while r2 > 0
      q = r / r2
      r, u, v, r2, u2, v2 = r2, u2, v2, r - q * r2, u - q * u2, v - q * v2
    end

    { pgcd: r, u: u, v: v }
  end

  def self.inverse_modulaire(a, n)
    val = euclide_etendu a, n
    raise Exception, "Can't find value for a: #{a} and n: #{n}" unless val[:pgcd] == 1

    val[:u] % n
  end

  def self.generation_exposants(p, q)
    phi = (p - 1) * (q - 1)
    c = 2

    while c < phi
      break if c.gcd(phi) == 1

      c += 1
    end

    { c: c, d: inverse_modulaire(c, phi) }
  end

  def self.chiffrement(m, n, c)
    exponentiation_modulaire m, c, n
  end

  def self.dechiffrement(m, n, d)
    exponentiation_modulaire m, d, n
  end

  def self.string_to_integer(message)
    message = message.upcase.split(//)
    value = 0

    message.each_with_index do |char, i|
      value = value + (ALPHABET.length ** (message.length - 1 - i)) * ALPHABET.index(char)
    end
    value
  end

  def self.integer_to_string(number)
    quotient = number / ALPHABET.length
    remainder = number % ALPHABET.length
    message = "#{ALPHABET[remainder]}"

    while quotient > ALPHABET.length
      remainder = quotient % ALPHABET.length
      quotient = quotient / ALPHABET.length
      message += ALPHABET[remainder]
    end
    (message + ALPHABET[quotient].to_s).reverse
  end

  def self.decode(message, n, c)
    p = n.prime_division[0][0]
    q = n.prime_division[1][0]

    d = RSA.inverse_modulaire(c, (p - 1) * (q - 1))

    message = RSA.string_to_integer message

    RSA.integer_to_string RSA.dechiffrement message, n, d
  end
end
