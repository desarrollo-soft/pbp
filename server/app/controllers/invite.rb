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
    if @invite == nil
      redirect url(:home, :index)
    else
      render 'character/create'
    end
  end

  post :accept, :with => :id do
    @invite = CampaignInviteUser.get params[:id]
    @character = Character.new
    @character.campaign_id = @invite.campaign_id
    @character.user_id = @invite.user_id
    @character.name = params[:name]
    @character.bio = params[:bio]
    @character.stats = params[:stats]
    if @character.save
      @invite.destroy
      redirect url(:campaign, :view, @invite.campaign_id)
    else
      render 'character/create'
    end
  end

  get :reject, :with => :id do
    @invite = CampaignInviteUser.get params[:id]
    @invite.reject
    redirect url(:invite, :pending)
  end
end
