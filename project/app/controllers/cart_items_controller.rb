class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy, :increase, :decrease]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_item = CartItem.new
    @cart_items = if current_user.usertype.zero?
                    CartItem.all
                  else
                    CartItem.where(user_id: current_user.id)
                  end
    @button_group = if current_user.usertype == 1
                      {'Go shopping!' => items_path }
                    else
                      {}
                    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    item = CartItem.where(user_id: current_user.id, item_id: cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)

    respond_to do |format|
      # if item already in cart then send a message and go back
      if !item.empty?
        format.html { redirect_to cart_items_path, flash: { info: 'This item has already been in your cart.' } }
      elsif @cart_item.save
        format.html { redirect_to cart_items_path, notice: 'Cart item was successfully created.' }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increase
    @cart_item = @cart_item.add_one(@cart_item)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_back fallback_location: cart_items_path }
        format.js
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrease
    @care_item = @cart_item.remove_one(@cart_item)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to cart_items_path }
        format.js
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  # The required params format: {cart_item: {item_id: , user_id: , num: }}
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :user_id, :num)
  end
end
