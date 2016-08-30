class Util

  class << self

    def symbolize_keys(hash)
      hash = hash.inject({}){ |memo, (k, v)| memo[k.to_sym] = v; memo }
      hash
    end

    def blank?(value)
      value.nil? || value.length.zero?
    end

  end

end