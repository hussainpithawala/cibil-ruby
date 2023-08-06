# frozen_string_literal: true

RSpec.describe Cibil::TUDF::Generator::Header do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  it 'should emitSegmentTag' do
    expect(Cibil::TUDF::Generator::Header::Field.new('SegmentTag', 4, 'TUDF').emit).to eq('TUDF')
  end
  it 'should emitVersion' do
    expect(Cibil::TUDF::Generator::Header::Field.new('Version', 2, '12').emit).to eq('12')
  end
  it 'should emitReportingMemberOrProcessorUserId' do
    expect(Cibil::TUDF::Generator::Header::Field.new('ReportingMemberOrProcessorUserId', 30, 'DUMMY123').emit).to eq('DUMMY123                      ')
  end
  it 'should emitReportingMemberOrProcessorShortName' do
    expect(Cibil::TUDF::Generator::Header::Field.new('ReportingMemberOrProcessorShortName', 16, 'DUMMY').emit).to eq("DUMMY           ")
  end
  it 'should emitCycleIdentification' do
    expect(Cibil::TUDF::Generator::Header::Field.new('CycleIdentification', 2, '10').emit).to eq("10")
  end
  it 'should emitDateReportedAndCertified' do
    expect(Cibil::TUDF::Generator::Header::Field.new('DateReportedAndCertified', 8, '30122022').emit).to eq("30122022")
  end
  it 'should emitReportingPassword' do
    expect(Cibil::TUDF::Generator::Header::Field.new('ReportingPassword', 30, 'DUMMYPASS').emit).to eq("DUMMYPASS                     ")
  end
  it 'should emitAuthenticationMethod' do
    expect(Cibil::TUDF::Generator::Header::Field.new('AuthenticationMethod', 1, 'A').emit).to eq("A")
  end
  it 'should emitFutureUse' do
    expect(Cibil::TUDF::Generator::Header::Field.new('FutureUse', 5, 'A', '0').emit).to eq("A0000")
  end
  it 'should emitMemberData' do
    expect(Cibil::TUDF::Generator::Header::Field.new('MemberData', 48, 'A').emit).to eq("A                                               ")
  end
  it 'should emit Header Row' do
    expected_row = 'TUDF12DUMMY123                      DUMMY           1030122022PASSWORD                      AA0000A                                               '
    actual_row = Cibil::TUDF::Generator::Header::Row.new('DUMMY123', 'DUMMY', 'PASSWORD', '10', '30122022').emit
    expect(actual_row).to eq(expected_row)
  end

end
