require 'spec_helper'

describe 'concat' do
  context 'with a file' do
    let (:params) { {:name => '/etc/dummy', :notify =>  Service['named'] } }

  end
end
