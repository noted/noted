# encoding: utf-8

module Rubocop
  module Cop
    class ArrayLiteral < Cop
      ERROR_MESSAGE = 'Use array literal [] instead of Array.new.'

      def inspect(file, source, tokens, sexp)
        offences = preliminary_scan(sexp)

        # find Array.new()
        each(:method_add_arg, sexp) do |s|
          next if s[1][0] != :call

          receiver = s[1][1][1]
          method_name = s[1][3][1]

          if receiver && receiver[1] == 'Array' &&
              method_name == 'new' && s[2] == [:arg_paren, nil]
            offences.delete(Offence.new(:convention,
                                        receiver[2].lineno,
                                        ERROR_MESSAGE))
            add_offence(:convention,
                        receiver[2].lineno,
                        ERROR_MESSAGE)
          end

          # check for false positives
          if receiver && receiver[1] == 'Array' &&
              method_name == 'new' && s[2] != [:arg_paren, nil]
            offences.delete(Offence.new(:convention,
                                        receiver[2].lineno,
                                        ERROR_MESSAGE))
          end
        end

        offences.each { |o| add_offence(*o.explode) }
      end

      def preliminary_scan(sexp)
        offences = []

        # find Array.new
        # there will be some false positives here, which
        # we'll eliminate later on
        each(:call, sexp) do |s|
          receiver = s[1][1]

          if receiver && receiver[1] == 'Array' &&
              s[3][1] == 'new'
            offences << Offence.new(:convention,
                                    receiver[2].lineno,
                                    ERROR_MESSAGE)
          end
        end

        offences
      end
    end
  end
end
