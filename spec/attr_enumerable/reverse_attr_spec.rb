# encoding: utf-8
require 'spec_helper'
require 'attr_enumerable'

describe AttrEnumerable do
  context :reverse_attr do
    class AttrEnumerablePerson
      attr_reader :name, :age
      def initialize(name, age)
        @name, @age = name, age
      end
    end

    class AttrEnumerablePersons
      attr_reader :attr_enumerable_persons
      include AttrEnumerable
      def initialize(attr_enumerable_persons = [])
        @attr_enumerable_persons = attr_enumerable_persons
      end

      def <<(person)
        @attr_enumerable_persons << attr_enumerable_persons
      end
    end

    cases = [
      {
        case_no: 1,
        case_title: 'name case',
        klass: AttrEnumerablePersons.new(
          [
            AttrEnumerablePerson.new('tanaka', 84),
            AttrEnumerablePerson.new('suzuki', 103)
          ]
        ),
        method: :reverse_name,
        expected: ['suzuki', 'tanaka']
      },
      {
        case_no: 2,
        case_title: 'age case',
        klass: AttrEnumerablePersons.new(
          [
            AttrEnumerablePerson.new('tanaka', 84),
            AttrEnumerablePerson.new('suzuki', 103)
          ]
        ),
        method: :reverse_age,
        expected: [103, 84]
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          actual = c[:klass].send c[:method]

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
