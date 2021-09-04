class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = case current_user.usertype
              when 0  # Admin
                Order.all
              when 1  # Consumer
                Order.where(user_id: current_user.id)
              when 2  # Store
                k = Item.select(:id).where(user_id: current_user.id)
                Order.where(item_id: k)
              else
                Order.new
              end
    @button_group = {}
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @cart_item = params[:cart_item]
    @item = Item.find(@cart_item[:item_id])

    if Address.where(user_id: current_user.id).length.zero?
      respond_to do |format|
        format.html { redirect_to addresses_path, alert: 'Please set your address before make orders.' }
      end
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)


    # delete cart_item from cart
    @cart_item = CartItem.find_by(item_id: @order.item_id)
    @cart_item.destroy

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:item_id, :user_id, :address_id, :num, :remark, :EMS_code, :state)
  end
end
