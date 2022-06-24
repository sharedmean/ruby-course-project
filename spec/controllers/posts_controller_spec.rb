require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  #let(:params) { { user_id: user } }

  before { sign_in user }

  describe '#index' do
    subject { process :index }

    let(:posts) { create_list(:post, 5) }
    

    it 'renders thed index template' do
      subject
      expect(response).to render_template :index
    end

    #it 'assigns @posts' do
    #  subject
    #  expect(assigns(:posts)).to eq posts
    #end

    context 'when user is not signed is' do # we use context because it's a clause
      before { sign_out user }
      it 'redirects to the log in page' do
          subject 
          expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#new' do
    subject { process :new }
  
    context 'when user signed in' do
      before { sign_in user }
        
      it 'redirects to new post page' do
        subject
        expect(response).to render_template(:new)
      end 
    end
  end

  describe '#create' do
    subject { process :create, method: :post, params: params } # attributes_for returns a hash with values
    
    let(:params) { { post: attributes_for(:post) } }
  
    it 'creates a post' do
      expect { subject }.to change(Post, :count).by(1)
    end

    it 'redirects to post page' do
      subject
      expect(response).to redirect_to post_path(Post.last)
    end 
  
    it 'assigns post to current user' do
      subject
      expect(assigns(:post).user).to eq user
    end

    context 'when params are invalid' do
      let(:params) do
        { user_id: user.id, post: { title: nil } }
      end
    
      it 'redirects to new post page again' do
        subject
        expect(response).to render_template(:new)
      end  
    end
  end

  describe '#destroy' do
    subject { process :destroy, method: :delete, params: params }
    let!(:post) { create :post, user: user}
    let(:params) { { id: post.id } }
    
    it 'deletes the post' do
        expect { subject }.to change(user.posts, :count).by(-1)
    end

    it 'redirects to posts index' do
      subject
      expect(response).to redirect_to home_path
    end

    context 'when user tries to delete foreign post' do
      let(:post) { create :post } # we create a new post, that belongs to other user

      it 'raises an exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound).and(change(user.posts, :count).by(0))
      end
    end
  end

  describe '#show' do
    subject { process :show, params: params }
    let!(:post) { create :post, user: user}
    let(:params) { { id: post.id } }
    
    it 'assigns @post' do
      subject
      expect(assigns(:post)).to eq(post)
    end
    
    it 'redirects to post' do
      subject
      expect(response).to render_template(:show)
    end 
  end

  describe '#edit' do
    subject { process :edit, params: params }
    let!(:post) { create :post, user: user}
    let(:params) { { id: post.id } }

    it 'assigns @post' do
      subject
      expect(assigns(:post)).to eq(post)
    end
  end

  describe '#update' do
    subject { process :update, method: :update, params: params }
    let!(:post) { create :post, user: user}
    let(:params) { { id: post, user_id: user, post: { title: 'A new title' } } }
    
    it 'updates post' do
      expect { subject }.to change { post.reload.title }.to('A new title')
    end

    context 'when params are invalid' do
      let(:params) { { id: post, user_id: user, post: { title: nil } } }  

      it 'redirects to edit post page again' do
        subject
        expect(response).to render_template(:edit)
      end  
    end 
  end
end
