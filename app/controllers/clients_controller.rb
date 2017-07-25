class ClientsController < ApplicationController
  PAGE_SIZE = 10

  def index
    @page = (params[:page] || 0).to_i
    @page_size = (params[:page_size] || PAGE_SIZE).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      client_search_term = ClientSearchTerm.new(@keywords)
      @clients = Client.where(client_search_term.where_clause, client_search_term.where_args).
        order(client_search_term.order).
        offset(@page_size * @page).
        limit(@page_size)
    else
      #@clients = []
      @clients = Client.all.limit(@page_size)
    end

    respond_to do |format|
      format.html { }
      format.json {
        render json: { clients: @clients }
      }
    end
  end
end
