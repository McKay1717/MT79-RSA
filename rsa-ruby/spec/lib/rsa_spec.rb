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
      expect(RSA.euclide_etendu(120, 23)).to eq({ pgcd: 1, u: -9, v: 47 })
    end

    it 'Return modular inverse' do
      value = RSA.inverse_modulaire 334, 223
      expect(value).to eq 221
    end

    it 'Return c and d' do
      value = RSA.generation_exposants 53, 97
      expect(value).to eq(c: 5, d: 1997)
    end
  end
end