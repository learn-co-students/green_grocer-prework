require "pry"

def consolidate_cart(cart)
  #cart_hash = {}
  cart.each_with_object({}) do |food_item_key, food_item_value|
 #   food_item_frequency = cart.count(food_item_hash)
 #   food_item_hash.each do |food_item_key, attribute_hash|
 #     attribute_hash[:count] = food_item_frequency
#      binding.pry # after exiting three times through the first cart in the tests, food_item_hash properly returns {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}} .  The count properly registers as 2   (and, of course, attribute_hash properly returns {:price=>3.0, :clearance=>true, :count=>2}   ).
# attribute_hash.each do |attribute_symbol, attribute_value|

  food_item_key.each do |k, v|
 #   binding.pry
        if food_item_key[:k] 
          v[:count] += 1
            
          
        else  
          v[:count] = 1
  
        end 
      
        cart_hash = cart_hash.uniq
#     cart_hash = {food_item_key => {attribute_symbol => attribute_value, attribute_symbol => attribute_value, :count => food_item_frequency}}
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
