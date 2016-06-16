require 'bundler/setup'
require 'serverspec'
require 'docker'

describe 'Dockerfile' do
  image = Docker::Image.build_from_dir('.')

  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  it 'installs Ubuntu 14.04' do
    expect(os_version).to include('Ubuntu 14.04')
  end

  %w(ruby2.3 ruby2.3-dev nodejs libpq-dev postgresql-client).each do |package|
    describe package(package) do
      it { should be_installed }
    end
  end

  def os_version
    command('lsb_release -a').stdout
  end
end
