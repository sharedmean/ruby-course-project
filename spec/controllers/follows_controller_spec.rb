require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:user_follower) { create :user }
  let(:user_following) { create :user }

  before { sign_in user_follower }
  
  describe '#create' do
    subject { process :create, method: :post, params: params, format: :js } # attributes_for returns a hash with values
    
    let(:params) { { follow: { follower_id: user_follower.id, following_id: user_following.id } } }

    it 'follows' do
      expect { subject }.to change(Follow, :count).by(1)   
      subject
      expect(response.body).to eq("location.reload();")
    end    
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params, format: :js }

    let!(:follow) { create :follow, follower: user_follower, following: user_following}
    let(:params) { { id: user_following.id } }
    
    it 'deletes the follow' do
      expect { subject }.to change(user_follower.following_follows, :count).by(-1)
      subject
      expect(response.body).to eq("location.reload();")
    end

    context 'when user tries to delete foreign follow' do
      let(:user) { create :user }
      let!(:follow) { create :follow, follower: user, following: user_following} # we create a new follow, that belongs to other NEW user
      
      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end
  end
end
