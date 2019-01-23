class ShipsController < ApplicationController

	def index
		@ships = Ship.all
		#options = {include: [:scores]}
		render json: ShipSerializer.new(@ships)
	end

	def create
    	@ship = Ship.new(ship_params)
	    if @ship.save
				@score = Score.new(ship: @ship)
				#options = {include: [:scores]}
				ActionCable.server.broadcast 'match',
					name:@ship.name,
					shipId: @ship.id,
					color: @ship.color
				render json: ShipSerializer.new(@ship)
	    end
  	end

	def show
		@ship = Ship.find(params[:id])
		render json: ShipSerializer.new(@ship)
	end

	def update
		@ship = Ship.find(params[:id])
		# if @ship.update.valid?
		# 	MatchChannel.broadcast_to(@ship, )
		# 	render json: ShipSerializer.new(@ship)
		# end
	end

	private

	def ship_params
		params.require(:ship).permit(:email, :name, :color)
	end

end
