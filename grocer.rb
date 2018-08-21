require "pry"
# each_with_object

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |food_item_hash|
    food_item_frequency = cart.count(food_item_hash)
    food_item_hash.each do |food_item_key, attribute_hash|
      attribute_hash[:count] = food_item_frequency
        if cart_hash == {}
          cart_hash = {food_item_key => attribute_hash}
        else  
          cart_hash[food_item_key] = attribute_hash
        end
    end 
  end 
  cart_hash
end


	
Amelie Oller 9 MINUTES AGO
Hey Omar :smile:

Amelie Oller 9 MINUTES AGO
How is it going?
Omar Gonzalez 9 MINUTES AGO
Okay. A bit tired. Would like to resolve this method before going to bed.


Amelie Oller 8 MINUTES AGO
Well, it is late, that makes sense :smile:

Amelie Oller 8 MINUTES AGO
alright, let's do it :smile:




def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end