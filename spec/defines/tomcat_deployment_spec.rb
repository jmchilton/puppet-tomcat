require 'spec_helper'

describe 'tomcat::deployment' do
  let(:title) { 'example' }
  let(:params) { {:path => 'http://example.com/example.war' } }

  it { should include_class('tomcat') }

  it { should contain_exec('wget-war-example') }

end
