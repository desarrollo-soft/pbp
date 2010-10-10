Pbp.controller do
  get "/" do
    redirect url(:home, :index)
  end
end
