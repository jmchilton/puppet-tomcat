require 'spec_helper'

describe 'tomcat' do

  let :facts do
    {
      :osfamily => 'Debian'
    }
  end

  describe 'the default behavior' do

    it { should contain_package('tomcat6') }

  end

end
