class PizzasController < ApplicationController
  # GET /pizzas
  # GET /pizzas.json
  def index
    @pizzas = Pizza.all
    authorize! :index, Pizza

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pizzas }
    end
  end

  # GET /pizzas/1
  # GET /pizzas/1.json
  def show
    @pizza = Pizza.find(params[:id])
    authorize! :show, @pizza

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pizza }
    end
  end

  # GET /pizzas/new
  # GET /pizzas/new.json
  def new
    @pizza = Pizza.new
    @ingredients = Ingredient.all
    authorize! :new, @pizza

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pizza }
    end
  end

  # GET /pizzas/1/edit
  def edit
    @pizza = Pizza.find(params[:id])
    @ingredients = Ingredient.all
    authorize! :edit, @pizza
  end

  # POST /pizzas
  # POST /pizzas.json
  def create
    @pizza = Pizza.new(params[:pizza])
    @ingredients = Ingredient.all
    authorize! :create, @pizza

    respond_to do |format|
      if @pizza.save
        format.html { redirect_to @pizza, notice: 'Pizza was successfully created.' }
        format.json { render json: @pizza, status: :created, location: @pizza }
      else
        format.html { render action: "new" }
        format.json { render json: @pizza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pizzas/1
  # PUT /pizzas/1.json
  def update
    @pizza = Pizza.find(params[:id])
    authorize! :update, @pizza

    respond_to do |format|
      if @pizza.update_attributes(params[:pizza])
        format.html { redirect_to @pizza, notice: 'Pizza was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pizza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pizzas/1
  # DELETE /pizzas/1.json
  def destroy
    @pizza = Pizza.find(params[:id])
    authorize! :destroy, @pizza
    @pizza.destroy

    respond_to do |format|
      format.html { redirect_to pizzas_url }
      format.json { head :no_content }
    end
  end

  # POST /pizzas/1/order
  def order
    @pizza = Pizza.find(params[:id])

    @order = current_user.orders.last
    if not @order then
      @order = current_user.orders.build
    end

    case @order.status
      when :open
        @order.order_elements.build( :pizza => @pizza,
                                    :quantity => params[:order_element][:quantity] )
      when :made, :paid
        @order = nil
      when :closed
        @order = Order.new
        @order.order_elements.build( :pizza => @pizza,
                                    :quantity => params[:order_element][:quantity] )
        current_user.orders << @order
    end

    respond_to do |format|
      if @order then
        if @order.save
          format.html { redirect_to pizzas_path, notice: "Added pizza '#{@pizza.name}' to your order." }
          format.json { render json: @order, status: :created, location: @order }
        else
          format.html { render action: "new" }
          format.json { render json: @pizza.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to pizzas_path, alert: 'Please finalize current order first.' }
        format.js { redirect_to pizzas_path, alert: 'Please finalize current order first.' }
        format.json { render json: @pizza.errors, status: :unprocessable_entity }        
      end
    end    
  end
end
