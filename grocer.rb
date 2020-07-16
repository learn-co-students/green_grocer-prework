
def consolidate_cart(original_cart)
new_hash = {}
original_cart.each do |hash|
  hash.each do |food_item, details|
    if !new_hash.include?(food_item)
      new_hash[food_item] = details
    new_hash[food_item][:count] = 1
  elsif new_hash.include?(food_item)
    new_hash[food_item][:count] +=1
  end
end
end
new_hash
end

def apply_coupons(cart, coupons)
  
    coupons.each do |coupon|
      item = coupon[:item]

      if cart[item] && cart[item][:count]  >= coupon[:num]
      #  cart[fruit][:count] = cart[fruit][:count] - coupon[:num]

        if cart[item + " W/COUPON"]
          cart[item + " W/COUPON"][:count] += 1

        else
        cart[item + " W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart[item + " W/COUPON"][:clearance] = cart[item][:clearance]
        #end
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end


  def apply_clearance(cart)
  # code here
  cart.each do |food_key, food_values_hash|

    food_values_hash.each do |price_clearance_count, values|

      if cart[food_key][price_clearance_count] == true
      cart[food_key][:price] = (cart[food_key][:price] - (cart[food_key][:price] * 0.2))
      end
    end

  end


end



  def checkout( cart, coupons)

  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0

  cart.each do |foods, food_values_hash|
    total +=(food_values_hash[:price] * food_values_hash[:count])
  end

  if total > 100.0
    total = (total - (total * 0.1))
  end
total
end
