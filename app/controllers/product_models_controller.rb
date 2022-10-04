class ProductModelsController < ApplicationController

  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :height, :width, :depth, :weight, :sku, :supplier_id)
    @product_model = ProductModel.new(product_model_params)

    if  @product_model.save
      redirect_to @product_model, notice: 'Modelo de produto cadastrado com sucesso'
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar o modelo de produto'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def edit
    @product_model = ProductModel.find(params[:id])
    @suppliers = Supplier.all
  end

  def update
    @product_model = ProductModel.find(params[:id])
    product_model_params = params.require(:product_model).permit(:name, :height, :width, :depth, :weight, :sku, :supplier_id)
    if @product_model.update(product_model_params)
      redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto atualizado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível atualizar o modelo de produto'
      render 'edit'
    end
  end
end
