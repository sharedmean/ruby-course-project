require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:post) { create :post }

  before { sign_in user }
  
  describe '#create' do
    subject { process :create, method: :post, params: params } # attributes_for returns a hash with values
    
    let(:params) { { user_id: user.id, post_id: post.id, comment: attributes_for(:comment) } }
    it 'creates a comment' do
      expect { subject }.to change(Comment, :count).by(1)
    end

    it 'assigns comment to current user' do
      subject
      expect(assigns(:comment).user).to eq user
    end

    it 'assigns comment to current post' do
      subject
      expect(assigns(:comment).post).to eq post
    end

    it 'redirects to post page' do
      subject
      expect(response).to redirect_to post_path(post)
    end 

    context 'when params are invalid' do
      let(:params) { { user_id: user.id, post_id: post.id, comment: { body: nil } } }
    
      it 'redirects to post page again' do
        subject
        expect(response).to redirect_to post_path(post)
      end  
    end    
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params }
    let!(:comment) { create :comment, post: post, user: user}
    let(:params) { { id: comment.id, post_id: post.id } }
    
    it 'deletes the comment' do
      expect { subject }.to change(post.comments, :count).by(-1)
    end

    it 'redirects to post page' do
      subject
      expect(response).to redirect_to post_path(post)
    end 

    context 'when user tries to delete foreign comment' do
      let(:comment) { create :comment } # we create a new comment, that belongs to other NEW user

      it 'raises an exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound).and(change(post.comments, :count).by(0))
      end
    end
  end
end
