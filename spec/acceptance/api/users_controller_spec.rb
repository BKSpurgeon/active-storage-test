require 'acceptance_helper'
require 'action_dispatch/testing/test_process'

resource 'Api' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  header 'Host', 'example.com'

  describe 'POST /api/users' do
    post '/api/users' do
      let(:avatar) { fixture_file_upload(Rails.root.join('public', 'avatar.jpg'), 'image/jpg') }
      let(:username) { 'Test User' }
      let(:params) { {  user: { username: username, avatar: avatar } } }

      context 'with avatar' do
        it { expect { do_request(params) }.to change { ActiveStorage::Attachment.count }.from(0).to(1) }
      end
    end
  end
end
