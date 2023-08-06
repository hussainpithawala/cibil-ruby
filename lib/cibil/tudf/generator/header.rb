# frozen_string_literal: true

module Cibil
  module TUDF
    module Generator
      module Header
        class Field
          attr_accessor :field_name, :field_length, :field_value, :pad_character

          def initialize(field_name, field_length, field_value, pad_character = ' ')
            # field_name is for identification purpose only. It is not emitted by the generator
            @field_name = field_name
            @field_length = field_length
            @field_value = field_value
            @pad_character = pad_character
          end

          def emit
            value_length = @field_value.length

            if value_length == @field_length
              @field_value
            elsif value_length <= @field_length
              padding_length = @field_length - value_length
              if @pad_character
                @field_value.ljust(@field_length, @pad_character)
              else
                @field_value.ljust(padding_length)
              end
            end
          end
        end

        class Row
          attr_accessor :member_id, :member_name, :member_password, :cycle_identification, :last_day_of_month

          def initialize(member_id, member_name, member_password, cycle_identification, last_day_of_month)
            @member_id = member_id
            @member_name = member_name
            @member_password = member_password
            @cycle_identification = cycle_identification
            @last_day_of_month = last_day_of_month
          end

          def emit
            ([
                      Cibil::TUDF::Generator::Header::Field.new('SegmentTag', 4, 'TUDF').emit,
                      Cibil::TUDF::Generator::Header::Field.new('Version', 2, '12').emit,
                      Cibil::TUDF::Generator::Header::Field.new('ReportingMemberOrProcessorUserId', 30, @member_id).emit,
                      Cibil::TUDF::Generator::Header::Field.new('ReportingMemberOrProcessorShortName', 16, @member_name).emit,
                      Cibil::TUDF::Generator::Header::Field.new('CycleIdentification', 2, '10').emit,
                      Cibil::TUDF::Generator::Header::Field.new('DateReportedAndCertified', 8, @last_day_of_month).emit,
                      Cibil::TUDF::Generator::Header::Field.new('ReportingPassword', 30, @member_password).emit,
                      Cibil::TUDF::Generator::Header::Field.new('AuthenticationMethod', 1, 'A').emit,
                      Cibil::TUDF::Generator::Header::Field.new('FutureUse', 5, 'A', '0').emit,
                      Cibil::TUDF::Generator::Header::Field.new('MemberData', 48, 'A').emit,
                    ].join(''))
          end
        end
      end
    end
  end
end