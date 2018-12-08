class TestsController < Simpler::Controller

  def index
    # render plain: "Go"
    #    status 201
    #    headers['Content-Type'] = 'text/plain'
  end

  def create

  end

  def show
    @id = params[:id]
  end

end
