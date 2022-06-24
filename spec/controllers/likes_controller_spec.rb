require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post }

  before { sign_in user }
  
  describe '#create' do
    subject { process :create, method: :post, params: params, format: :js } # attributes_for returns a hash with values
    
    let(:params) { { user_id: user.id,  like: { post_id: post.id } } }

    it 'creates a like' do
      expect { subject }.to change(Like, :count).by(1)   
      subject
      expect(response.body).to eq("location.reload();")
    end

    it 'assigns like to current user' do
      subject
      expect(assigns(:like).user).to eq user
      subject
      expect(response.body).to eq("location.reload();")
    end

    it 'assigns like to current post' do
      subject
      expect(assigns(:like).post).to eq post
      subject
      expect(response.body).to eq("location.reload();")
    end
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params, format: :js }
    let!(:like) { create :like, post: post, user: user}
    let(:params) { { id: like.id } }
    
    it 'deletes the like' do
      expect { subject }.to change(post.likes, :count).by(-1)
      subject
      expect(response.body).to eq("location.reload();")
    end

    context 'when user tries to delete foreign like' do
      let(:like) { create :like } # we create a new comment, that belongs to other NEW user

      it 'raises an exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
