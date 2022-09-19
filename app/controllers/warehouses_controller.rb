class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    #receber os dados enviados
    # criar um novo X no bd
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) #Strong Parameters
    w = Warehouse.new(warehouse_params)
    w.save()
    #redirecionar para root
    redirect_to root_path
  end
end