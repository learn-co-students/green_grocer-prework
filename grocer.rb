def consolidate_cart(cart)
  new_hash = {}
  cart.each{|ele|
    ele.each{|item, values|
    if new_hash[item] == nil
      new_hash[item] = {}
      new_hash[item] = values
      new_hash[item][:count] = 1
    else
      new_hash[item][:count] += 1
    end
    }
  }
  new_hash      
end

def apply_coupons(cart, coupons)
  coupons.each { |coupon|
    item = coupon[:item]
    if cart[item] != nil && cart[item][:count] >= coupon[:num]
      cart[item][:count] -= coupon[:num]
      if cart["#{item} W/COUPON"] == nil
        cart["#{item} W/COUPON"] = {}
        cart["#{item} W/COUPON"][:price] = coupon[:cost]
        cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        cart["#{item} W/COUPON"][:count] = 1
      else  
        cart["#{item} W/COUPON"][:count] += 1
      end
    end
  }
  cart
end

def apply_clearance(cart)
  # code here
  cart.each{|goods, ele|
    if ele[:clearance] == true
        ele[:price] = (ele[:price] * 0.8).round(2)
    else
      cart[goods][:price] *= 1
    end
  }
  cart
end

def checkout(cart, coupons)
  # code here
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)
  sum = 0
  cart3.each{|item, ele|
    price = (ele[:price] * ele[:count]).round(2)
    sum += price
  }
  if sum > 100
    sum = (sum * 0.9).round(2)
  end
  sum
end
