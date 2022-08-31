class BlocksController < ApplicationController
  before_action :set_block, only: %i[ show edit update destroy ]

  # GET /blocks or /blocks.json
  def index
    @pagy, @blocks = pagy(Block.all.order("created_at DESC"), items: 4)
  end

  # GET /blocks/1 or /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks or /blocks.json
  def create
    require "httparty"
    hash_block = params[:block][:hash_block]
    url = "https://blockchain.info/rawblock/#{hash_block}"
    response = HTTParty.get(url)
    block_info = JSON.parse(response.body)
    # hash_block = block_info["hash"]
    prev_block = block_info["prev_block"]
    block_index = block_info["block_index"]
    time = block_info["time"]
    bits = block_info["bits"]
    # @block = Block.new(block_params)
    @block = Block.new(hash_block:, prev_block:, block_index:, time:, bits:)

    respond_to do |format|
      if @block.save
        flash.now[:notice] = "Block was successfully created."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("blocks",
                                 partial: "blocks/block",
                                locals:{block: @block}),
            turbo_stream.update("new_block",
                                  partial: "blocks/form",
                                 locals:{block: Block.new}),
            turbo_stream.update("flash", partial: "layouts/flash")
          ]
        end
        format.html { redirect_to blocks_url, notice: "Block was successfully created." }
        format.json { render :show, status: :created, location: @block }
      else
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.update("new_block", partial: "blocks/form", locals: {block: @block})
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1 or /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to block_url(@block), notice: "Block was successfully updated." }
        format.json { render :show, status: :ok, location: @block }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1 or /blocks/1.json
  def destroy
    @block.destroy
    flash.now[:notice] = "Block was successfully destroyed."
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@block),
          turbo_stream.update("flashdestroy", partial: "layouts/flashdestroy" )
        ]
      end
      format.html { redirect_to blocks_url, notice: "Block was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def block_params
      params.require(:block).permit(:hash_block, :prev_block, :block_index, :time, :bits)
    end
end
