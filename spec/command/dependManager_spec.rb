require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Dependmanager do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ dependManager }).should.be.instance_of Command::Dependmanager
      end
    end
  end
end

