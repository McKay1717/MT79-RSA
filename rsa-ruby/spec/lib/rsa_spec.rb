require 'rsa'

# OpenSSL is included to test our algorithms against OpenSSL C library
require 'openssl'

RSpec.describe RSA do
  context 'Methods' do
    it 'Return modular exponentiation' do
      value = RSA.exponentiation_modulaire 4, 13, 497
      expect(value).to eq 445
      expect(value).to eq 4.to_bn.mod_exp(13, 497)
    end

    it 'Return GCD, u and v' do
      expect(RSA.euclide_etendu(120, 23)).to eq(pgcd: 1, u: -9, v: 47)
    end

    it 'Return modular inverse' do
      value = RSA.inverse_modulaire 334, 223
      expect(value).to eq 221
    end

    it 'Return c and d' do
      value = RSA.generation_exposants 53, 97
      expect(value).to eq(c: 5, d: 1997)
    end

    it 'Return crypted value' do
      value = RSA.chiffrement 123, 221, 5
      expect(value).to eq(106)
    end

    it 'Return uncrypted value' do
      value = RSA.dechiffrement 106, 221, 1997
      expect(value).to eq(123)
    end

    it 'Return String to Integer' do
      value = RSA.string_to_integer 'Bonsoir.'
      expect(value).to eq(26_943_298_110)
    end

    it 'Return Integer to String' do
      value = RSA.integer_to_string 26_943_298_110
      expect(value).to eq('Bonsoir.'.upcase)
    end

    it 'Return decoded message' do
      value = RSA.decode 'LHRZNS', 211_582_871, 127
      expect(value).to eq('RETI')
    end
  end
end
