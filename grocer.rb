def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each {|grocery|
    grocery.each {|name,atts|
      if new_cart.include?(name)
        new_cart[name][:count] += 1
      else
        new_cart[name] = atts
        new_cart[name][:count] = 1
      end
    }
  }
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  #coupons is an array of hashes
  #cart is a hash
  coupons.each{|coupon|
    item = coupon[:item]
    if cart.include?(item)
      cpn_quant = coupon[:num]
      cart_quant = cart[item][:count]
      if cpn_quant <= cart_quant
        item_w_cpn = item + " W/COUPON"
        cart[item_w_cpn] = {}
        cart[item].each {|key,value| cart[item_w_cpn][key] = value}
        cart[item_w_cpn][:price] = coupon[:cost]
        cart[item_w_cpn][:count] = cart_quant / cpn_quant
        cart[item][:count] = cart_quant % cpn_quant
      end
    end

  }
  cart
end

def apply_clearance(cart)
  # code here
  cart.each {|item, atts|
    if atts[:clearance]
      atts[:price] = (atts[:price] * 0.8).round(2)
    end
  }
end

def checkout(cart, coupons)
  # code here
  co_cart = consolidate_cart(cart)
  co_cart = apply_coupons(co_cart, coupons)
  co_cart = apply_clearance(co_cart)
  total = 0
  co_cart.each {|grocery, atts|
    total += (atts[:price] * atts[:count]).round(2)
  }
  if total > 100.00
    (total*0.9).round(2)
  else
    total
  end
end
