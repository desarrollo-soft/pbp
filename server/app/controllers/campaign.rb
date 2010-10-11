Pbp.controllers :campaign do
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

  get :new do
    @campaign = Campaign.new
    render 'campaign/new'
  end

  post :new do
    @campaign = Campaign.new
    @campaign.master_user_id = session[:user].id
    @campaign.name = params[:name]
    if @campaign.save
      id = @campaign.id
      redirect 'view/' + id.to_s
    else
      render 'campaign/new'
    end
  end

  get :list do
    @campaigns = Campaign.all(:master_user_id => session[:user].id)
    render 'campaign/list'
  end

  get :invite, :with => :id do
    @campaign = Campaign.get(params[:id])
    if (@campaign == nil)
      redirect url(:campaign, :list)
    else
      render 'campaign/invite'
    end
  end

  post :invite, :with => :id do
    @campaign = Campaign.get(params[:id])
    if (@campaign == nil)
      redirect url(:campaign, :list)
    else
      if @campaign.inviteUsernameOrEmail params[:username_or_email]
        redirect url(:campaign, :list)
      else
        render 'campaign/invite'
      end
    end
  end

  get :view, :with => :id do
  end

  get :edit, :with => :id do
  end

end
