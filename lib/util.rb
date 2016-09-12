class Util

  class << self

    def symbolize_keys(hash)
      hash.inject({}){ |memo, (k, v)| memo[k.to_sym] = v; memo }
    end

    def blank?(value)
      value.nil? || value.to_s.length.zero?
    end

  end

end