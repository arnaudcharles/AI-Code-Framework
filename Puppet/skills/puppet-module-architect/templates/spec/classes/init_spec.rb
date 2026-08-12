require 'spec_helper'

describe 'secure_module' do
  let(:facts) do
    {
      os: {
        family: 'Debian'
      }
    }
  end

  it { is_expected.to compile.with_all_deps }

  it 'manages config file with hardened mode' do
    is_expected.to contain_file('/etc/secure_module/config.conf').with(
      owner: 'root',
      mode: '0640'
    )
  end

  context 'with invalid service_port' do
    let(:params) { { service_port: 70000 } }

    it 'fails compilation' do
      is_expected.not_to compile
    end
  end
end
