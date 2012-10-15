#!/usr/bin/env rspec

require 'spec_helper'

describe 'concat::setup' do
 it { should contain_class('concat::setup') }
end
