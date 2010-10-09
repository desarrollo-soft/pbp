Pbp.controllers :authentication do
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

  enable :sessions

  get :login do
    if (session[:user] && session[:user][:id] > 0)
      redirect url(:home, :index)
    else
      render 'authentication/login'
    end
  end

  post :login do
    @user = User.authenticate(params[:username], params[:password])

    if @user
      session[:user] = @user
      redirect url(:home, :index)
    else
      render 'authentication/login'
    end
  end

  get :signup do
    render 'authentication/signup'
  end

  post :signup do
    @user = User.new
    @user.username = params[:username]
    @user.setPassword params[:password]
    if @user.save
      redirect url(:home, :index)
    else
      render 'authentication/signup'
    end
  end

  get :logout do
    session[:user] = nil
    redirect url(:authentication, :login)
  end

end
