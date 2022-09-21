class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    #receber os dados enviados
    # criar um novo X no bd
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) #Strong Parameters
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      #redirecionar para root
      #flash[:notice] = "Galpão cadastrado com sucesso"
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new' 
    end
  end
end