require 'active_support/core_ext/string'

module Arbor
  module Utils
    def parse_resource_name(type)
      validate(get_resource_name(type), Arbor::RESOURCES)
    end

    def get_resource_name(type)
      case type
      when Class
        # do reverse serialiser lookup instead
        type.name.pluralize.underscore
      else
        type.to_s.pluralize
      end
    end

    def validate(choice, options)
      unless options.include?(choice.to_sym)
        raise ArgumentError, "#{choice} is not a valid option: #{options}"
      end
      choice
    end

    def left_pad(array, num)
      num.times { array.unshift(nil) }
    end

    def attempt(enum)
      exception = nil
      enum.each do
        begin
          return yield
        rescue Exception => e
          exception = e
          next
        end
      end
      raise exception
    end
  end
end
