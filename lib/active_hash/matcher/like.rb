module ActiveHash::Matcher
  class Like
    class << self
      def forward(pattern)
        new(pattern, :forward)
      end

      def backward(pattern)
        new(pattern, :backward)
      end

      def partial(pattern)
        new(pattern, :partial)
      end
    end

    attr_accessor :pattern, :match

    def initialize(pattern, match=:partial)
      unless %i(forward backward partial).include?(match.to_sym)
        raise ArgumentError, 'unknown match type'
      end

      self.pattern = pattern
      self.match   = match.to_sym
    end

    def call(value)
      value = value.to_s
      case match
      when :forward  then value.start_with?(pattern)
      when :backward then value.end_with?(pattern)
      when :partial  then value.include?(pattern)
      else false
      end
    end
  end
end