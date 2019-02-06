class RSA
  # Implemented following this algorithm : https://en.wikipedia.org/wiki/Modular_exponentiation#Right-to-left_binary_method
  # Which is O(log(n))
  def self.exponentiation_modulaire(x, k, n)
    result = 1
    base   = x
    while k > 0
      if (k & 1) == 1
        result = (result * base) % n
      end
      k    = k >> 1
      base = (base ** 2) % n
    end
    result
  end

  # Implemented following : https://fr.wikipedia.org/wiki/Algorithme_d%27Euclide_%C3%A9tendu#L'algorithme
  def self.euclide_etendu(a, b)
    r, u, v, r2, u2, v2, q = a, 1, 0, b, 0, 1, 0

    while(r2 > 0) do
      q = r/r2
      r, u, v, r2, u2, v2 = r2, u2, v2, r-q*r2, u-q*u2, v-q*v2
    end

    {pgcd: r, u: u, v: v}
  end

  def self.inverse_modulaire(a, n)
    val = euclide_etendu a, n
    raise Exception.new("Can't find value for a: #{a} and n: #{n}") unless val[:pgcd] == 1
    val[:u] % n
  end

  def self.generation_exposants(p, q)
    phi = (p - 1) * (q - 1)
    c = 2

    while c < phi
      break if c.gcd(phi) == 1
      c += 1
    end

    {c: c, d: inverse_modulaire(c, phi)}
  end
end