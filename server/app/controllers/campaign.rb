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
    @campaigns = Campaign.all(:master_user_id => session[:user].id) + Campaign.all('character.user_id' => session[:user].id)
    render 'campaign/list'
  end

  get :invite, :with => :id do
      @campaign = Campaign.get(params[:id])
      unless @campaign != nil
        redirect url(:campaign, :list)
        return
      end

    if (@campaign.master_user_id != session[:user].id)
      redirect url(:campaign, :list)
    else
      render 'campaign/invite'
    end
  end

  post :invite, :with => :id do
      @campaign = Campaign.get(params[:id])
      unless @campaign != nil
        redirect url(:campaign, :list)
        return
      end

    if @campaign.inviteUsernameOrEmail params[:username_or_email]
      redirect url(:campaign, :list)
    else
      render 'campaign/invite'
    end
  end

  get :view, :with => :id do
      @campaign = Campaign.get(params[:id])
      unless @campaign != nil
        redirect url(:campaign, :list)
        return
      end

    render 'campaign/view'
  end

  get :edit, :with => :id do
  end

  post :post, :with => :id do
      @campaign = Campaign.get(params[:id])
      unless @campaign != nil
        redirect url(:campaign, :list)
        return
      end

    if @campaign.post(session[:user], params[:message])
      redirect url(:campaign, :view, params[:id])
    else
      render 'campaign/view'
    end
  end
end
