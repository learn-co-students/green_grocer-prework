def consolidate_cart(cart)
  consolidated_cart = {}

  cart.each do |el|
    el.each do |key, value|
      if consolidated_cart.has_key?(key)
        consolidated_cart[key][:count] += 1
      else !consolidated_cart.has_key?(key)
        consolidated_cart[key] = value
        consolidated_cart[key][:count] = 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|
      item = coupon[:item]

      if cart[item] && cart[item][:count]  >= coupon[:num]
          if cart[item + " W/COUPON"]
            cart[item + " W/COUPON"][:count] += 1
          else
            cart[item + " W/COUPON"] = {:price => coupon[:cost], :count => 1}
            cart[item + " W/COUPON"][:clearance] = cart[item][:clearance]
          end
          cart[item][:count] -= coupon[:num]
      end
    end
    cart
end

def apply_clearance(cart)

  cart.each do |grocery, details|
    details.each do |key, value|
      if cart[grocery][key] == true
         new_value = cart[grocery][:price] * 0.8
         rounded_value = new_value.round(2)
         cart[grocery][:price] = rounded_value
       else
         next
      end
    end
  end
  cart
end

def checkout(cart, coupons)

  register = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

  total = 0
  register.each do |grocery, details|
      total += details[:price] * details[:count]
  end

  if total > 100
    total *= 0.9
  end

  total.round(2)

end
