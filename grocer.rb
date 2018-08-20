require "pry"

def consolidate_cart(cart)
  cart_hash = {}
 new_cart_array = []
  cart.each do |food_item_hash|
    food_item_frequency = cart.count(food_item_hash)
    food_item_hash.each do |food_item_key, attribute_hash|
      attribute_hash[:count] = food_item_frequency
# attribute_hash.each do |attribute_symbol, attribute_value|
        if cart_hash = {}
          cart_hash = {food_item_key => attribute_hash}
        else  cart_hash[food_item_key] = attribute_hash
#    cart_hash = cart_hash.uniq
#     cart_hash = {food_item_key => {attribute_symbol => attribute_value, attribute_symbol => attribute_value, :count => food_item_frequency}}
      end
    end 
  end 
  cart_hash
end


def apply_coupons(cart, coupons)
  
end


def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end
