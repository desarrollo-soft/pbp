Pbp.controllers :invite do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  
  get :pending do
    @invites = CampaignInviteUser.all :user_id => session[:user][:id]
    render 'invite/pending'
  end

  get :accept, :with => :id do
    @invite = CampaignInviteUser.get params[:id]
    @invite.accept
    redirect url(:invite, :pending)
  end

  get :reject, :with => :id do
    @invite = CampaignInviteUser.get params[:id]
    @invite.reject
    redirect url(:invite, :pending)
  end
end
