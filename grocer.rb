def consolidate_cart(cart)
  return_hash = {}
  cart.each do |item|
    item.each do |food, properties|
      i = 1
      if return_hash[food] == nil
        return_hash[food] = properties.merge!(:count => i)
      elsif return_hash[food].has_key?(:count)
        return_hash[food][:count] += 1
      end
    end
  end
  return_hash
end

def apply_coupons(cart, coupons)
  return_hash = {}
  cart.each do |food, properties|
    if coupons == []
      return_hash[food] = properties
    end
    coupons.each do |coupon|
      if coupon[:item] == food && coupon[:num] <= properties[:count]
        if return_hash["#{food} W/COUPON"] == nil
          return_hash["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => properties[:clearance], :count => 1}
          properties[:count] = (properties[:count] - coupon[:num])
        else
          return_hash["#{food} W/COUPON"][:count] +=1
          properties[:count] = (properties[:count] - coupon[:num])
        end
        #return_hash[food] = {:price => properties[:price], :clearance => properties[:clearance], :count => (properties[:count] - coupon[:num])}
        return_hash[food] = {:price => properties[:price], :clearance => properties[:clearance], :count => properties[:count]}

      else
        return_hash[food] = properties
      end
    end
  end
  return_hash
end

def apply_clearance(cart)
  return_hash = {}
  cart.each do |food, properties|
    if properties[:clearance] == true
      return_hash[food] = {:price => (properties[:price] * 0.80).round(5), :clearance => properties[:clearance], :count => properties[:count]}
    else
      return_hash[food] = properties
    end
  end
  return_hash
end

def checkout(cart, coupons)

  iterated_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  puts iterated_cart
  cart_total = 0.00
  iterated_cart.each do |food, properties|
    if properties[:count] > 0
      cart_total += (properties[:count] * properties[:price]).to_f
    end
  end

  if cart_total > 100.00
    cart_total = cart_total * 0.90
  end

  cart_total
end
