require "pry"

def consolidate_cart(cart)
  hash = {}
  cart.each do | element |
    element.each do | name , values |
      if hash.has_key?(name) == false
        hash[name] = values
        hash[name][:count] = 1
      else
        hash[name][:count] += 1
      end
    end
  end
  return hash
end

def apply_coupons(cart, coupons)
  
  # cart = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  # coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]

  final_cart = {}
  
  cart.each do | food , food_info |
    coupons.each do | coupon_info |
      if food == coupon_info[:item] && food_info[:count] >= coupon_info[:num]
        food_info[:count] = food_info[:count] - coupon_info[:num]
        if final_cart[food + " W/COUPON"]
          final_cart[food + " W/COUPON"][:count] += 1
        else
          final_cart[food + " W/COUPON"] = {:price => coupon_info[:cost], :clearance => food_info[:clearance], :count => 1 }
        end
      end
    end
      final_cart[food] = food_info
    end
  return final_cart
end

  #   coupons.each do | coupons_hash |
  #     coupon_item = coupons_hash[:item] 
  #     new_coupon_hash = {
  #       :price => coupons_hash[:cost],
  #       :clearance => true,
  #       :count => coupons_hash[:num]
  #     }
    
  #   if cart.key?(coupon_item)
  #     new_coupon_hash[:clearance] = cart[coupon_item][:clearance]
  #     if cart[coupon_item][:count] >= new_coupon_hash[:count]
  #       new_coupon_hash[:count] = (cart[coupon_item][:count] / new_coupon_hash[:count]).floor
  #       cart[coupon_item][:count] = coupons_hash[:num] % cart[coupon_item][:count]
  #     end
  #     cart[coupon_item + " W/COUPON"] = new_coupon_hash
  #   end
  # end
  # return cart

def apply_clearance(cart)

  cart.each do | food , food_info |
    if food_info[:clearance] == true
      food_info[:price] = ("%0.1f" % (food_info[:price] * 0.8)).to_f
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do | food, food_info |
    total += (food_info[:price] * food_info[:count]).to_f
  if total > 100
    total = ("%0.1f" % (total * 0.9)).to_f
  end
end
  total
end
