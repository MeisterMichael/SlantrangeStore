
class ApplicationTaxService

	CALIFORNIA_TAX_PERCENT = 0.06

	def initialize( args = {} )
	end

	def calculate( obj, args = {} )

		return self.calculate_order( obj ) if obj.is_a? Order
		return self.calculate_cart( obj ) if obj.is_a? Cart

	end

	def process( order, args = {} )
		return true
	end

	protected

	def calculate_cart( cart )
		# don't know shipping country, so can't calculate
	end

	def calculate_order( order )
		return order unless order.billing_address.geo_country.abbrev == 'US' && order.billing_address.geo_state.try(:abbrev) == 'CA'

		taxable_amount = order.order_items.select(&:prod?).collect(&:subtotal)
		taxes = taxable_amount * CALIFORNIA_TAX_PERCENT

		tax_order_item = order.order_items.new( subtotal: taxes, title: "Tax", order_item_type: 'tax' )

		return order

	end

end
