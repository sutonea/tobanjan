require "tobanjan/version"

module Tobanjan
  module Choicer
    class FlattenChoicer
      def initialize
      end
    end
  end

  class ::Tobanjan::CandidateList
    def self.create(list, columns)
      list_column_method_names = columns.map {|col| ColumnMethodNames.new(col) }
      candidates = list.map {|elm|
        ::Tobanjan::CandidateList::Candidate.create_with_column_method_names(elm, list_column_method_names)
      }
      new(candidates)
    end

    def initialize(candidates)
      @candidates = candidates
    end

    def choice_by_column_name!(column_name)
      min = @candidates.map(&column_name).min
      result = @candidates.select{|candidate|candidate.send(column_name) == min}.sample
      result.send("increment_#{column_name}".to_sym, 1)
      result.elm
    end

    class ColumnMethodNames
      def initialize(column_name)
        @column_name = column_name
      end

      def variable
        "@#{@column_name}".to_sym
      end

      def incrementer
        "increment_#{@column_name}".to_sym
      end

      def reader
        "#{@column_name}".to_sym
      end
    end

    class Candidate
      attr_reader :elm

      def self.create_with_column_method_names(elm, list_column_method_names)
        new(elm, list_column_method_names)
      end

      def initialize(elm, list_column_method_names)
        @elm = elm
        list_column_method_names.each do |names|
          v = instance_variable_get(names.variable)
          unless v
            instance_variable_set(names.variable, 0)
          end

          self.define_singleton_method(names.reader) do
            instance_variable_get(names.variable)
          end

          self.define_singleton_method(names.incrementer) do |arg|
            val = instance_variable_get(names.variable) + arg
            instance_variable_set(names.variable, val)
            val
          end
        end
      end

    end
  end
end
