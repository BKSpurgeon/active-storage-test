require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "it attaches uploaded files" do
    it 'attaches the uploaded file' do
      file = fixture_file_upload(Rails.root.join('public', 'avatar.jpg'), 'image/jpg')
      expect {
        post api_users_path, params: { user: {username: "Ben", avatar: file } }
      }.to change(ActiveStorage::Attachment, :count).by(1)
    end
  end
end
